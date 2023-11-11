# frozen_string_literal: true

class CreateMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :scheduled_messages do |t|
      t.text :message
      t.string :channel
      t.string :status
      t.datetime :scheduled_at
      t.jsonb :metadata, default: {}
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
