class CreateScheduledMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :scheduled_messages do |t|
      t.text :message
      t.datetime :scheduled_at

      t.timestamps
    end
  end
end
