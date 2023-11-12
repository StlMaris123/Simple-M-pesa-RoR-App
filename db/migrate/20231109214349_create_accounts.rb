class CreateAccounts < ActiveRecord::Migration[7.1]
  def change
    create_table :accounts do |t|
      t.decimal :balance, default: 0.0
      t.references :user, null: false, foreign_key: true
      t.string :account_number, index: true
      t.string :account_status

      t.timestamps
    end
  end
end
