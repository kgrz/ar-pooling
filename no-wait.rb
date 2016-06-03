# This code user the NOWAIT locking scheme which will throw an error if a
# process tries to acquire a lock on a row which is already locked. That means
# both processes are trying to lock on to the *same* row, which is not we want
# to select unique row which is available.

require './connection'

update_function = lambda do |user|
  puts "Updating #{user.name}"
  AccountPool.transaction do
    pooled_account = AccountPool.lock('FOR UPDATE NOWAIT').first
    sleep(5)

    user.create_account!(account_number: pooled_account.account_number)
    pooled_account.destroy!
  end
end

fork { update_function.call(FIRST_USER) }
fork { update_function.call(SECOND_USER) }

Process.waitall

puts "Number of accounts: ", Account.count
