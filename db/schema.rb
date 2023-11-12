# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 20_231_109_214_916) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'account_transactions', force: :cascade do |t|
    t.decimal 'amount'
    t.string 'reference_number'
    t.string 'transaction_status'
    t.string 'transaction_type'
    t.string 'checkout_request_id'
    t.string 'merchant_request_id'
    t.bigint 'account_id'
    t.bigint 'sender_id'
    t.bigint 'recepient_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['account_id'], name: 'index_account_transactions_on_account_id'
    t.index ['recepient_id'], name: 'index_account_transactions_on_recepient_id'
    t.index ['sender_id'], name: 'index_account_transactions_on_sender_id'
  end

  create_table 'accounts', force: :cascade do |t|
    t.decimal 'balance', default: '0.0'
    t.bigint 'user_id', null: false
    t.string 'account_number'
    t.string 'account_status'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['account_number'], name: 'index_accounts_on_account_number'
    t.index ['user_id'], name: 'index_accounts_on_user_id'
  end

  create_table 'scheduled_messages', force: :cascade do |t|
    t.text 'message'
    t.string 'channel'
    t.string 'status'
    t.datetime 'scheduled_at', precision: nil
    t.jsonb 'metadata', default: {}
    t.bigint 'user_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['user_id'], name: 'index_scheduled_messages_on_user_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at', precision: nil
    t.datetime 'remember_created_at', precision: nil
    t.string 'phone'
    t.string 'first_name'
    t.string 'last_name'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index ['first_name'], name: 'index_users_on_first_name'
    t.index ['last_name'], name: 'index_users_on_last_name'
    t.index ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true
  end

  add_foreign_key 'account_transactions', 'accounts'
  add_foreign_key 'account_transactions', 'users', column: 'recepient_id'
  add_foreign_key 'account_transactions', 'users', column: 'sender_id'
  add_foreign_key 'accounts', 'users'
  add_foreign_key 'scheduled_messages', 'users'
end
