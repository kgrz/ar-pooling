require './connection'

update_function = lambda do |user|
  puts "Updating #{user.name}"
  AccountPool.transaction do
    pooled_account = AccountPool.lock(true).first
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
puts "First account number: #{Account.first.account_number}; user: #{Account.first.user.name}"
puts "Second account number: #{Account.last.account_number}; user: #{Account.last.user.name}"
