require 'active_record'

Dir.glob("models/*.rb").each do |file|
  require_relative file
end

ActiveRecord::Base.establish_connection(YAML.load_file('./config/database.yml')['development'])

AccountPool.destroy_all
User.destroy_all
Account.destroy_all

10.times do |count|
  AccountPool.create(account_number: count)
end

FIRST_USER = User.create(name: 'first')
SECOND_USER = User.create(name: 'second')
