class CreateUsersAccountsAccountPools < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
    end

    create_table :accounts do |t|
      t.integer :account_number
      t.references :user
    end

    create_table :account_pools do |t|
      t.integer :account_number
    end
  end
end
