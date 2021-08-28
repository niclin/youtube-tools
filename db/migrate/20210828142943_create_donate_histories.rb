class CreateDonateHistories < ActiveRecord::Migration[6.1]
  def change
    create_table :donate_histories do |t|
      t.integer :donate_event_id, null: false
      t.integer :money, null: false
      t.string :comment

      t.timestamps
    end
  end
end
