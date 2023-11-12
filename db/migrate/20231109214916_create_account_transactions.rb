class CreateAccountTransactions < ActiveRecord::Migration[7.1]
  def change
    create_table :account_transactions do |t|
      t.decimal :amount
      t.string :reference_number
      t.string :transaction_status
      t.string :transaction_type
      t.string :checkout_request_id
      t.string :merchant_request_id
      t.references :account, foreign_key: true
      t.references :sender, foreign_key: { to_table: :users }
      t.references :recepient, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
