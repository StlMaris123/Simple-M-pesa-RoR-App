class CreateMessages < ActiveRecord::Migration[7.1]
  def change
    create_table :messages do |t|
      t.text :message
      t.string :channel
      t.string :status
      t.datetime :scheduled_at
      t.jsonb :metadata

      t.timestamps
    end
  end
end
