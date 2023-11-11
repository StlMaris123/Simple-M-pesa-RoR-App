class CreateAccountTransactions < ActiveRecord::Migration[7.1]
  def change
    create_table :account_transactions do |t|
      t.decimal :amount
      t.string :reference_number
      t.string :transaction_status
      t.string :transaction_type
      t.references :account, null: false, foreign_key: true
      t.references :sender, null: false, foreign_key: { to_table: :users }
      t.references :recepient, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
