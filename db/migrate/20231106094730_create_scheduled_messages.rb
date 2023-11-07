# frozen_string_literal: true

class CreateScheduledMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :scheduled_messages do |t|
      t.text :message
      t.string :channel
      t.string :status
      t.datetime :scheduled_at
      t.jsonb :metadata, default: {}

      t.timestamps
    end
  end
end
