# This code is identical to the one used in no-wait.rb, except that this uses
# the "SKIP LOCKED" locking scheme. You can notice that in the second process
# the first row that's locked by the first process simply gets skipped. So we
# end up with two accounts as expected.
require './connection'

update_function = lambda do |user|
  puts "Updating #{user.name}"
  AccountPool.transaction do
    pooled_account = AccountPool.lock('FOR UPDATE SKIP LOCKED').first
    sleep(5)

    user.create_account!(account_number: pooled_account.account_number)
    pooled_account.destroy!
  end
end

fork { update_function.call(FIRST_USER) }
fork { update_function.call(SECOND_USER) }

ActiveRecord::Base.connection.reconnect!
Process.waitall

puts "Number of accounts: #{Account.count}"
