class CreateDonateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :donate_events do |t|
      t.integer :user_id, null: false
      t.integer :status, default: 0, null: false
      t.string :title, null: false
      t.integer :goal_amount, null: false
      t.integer :total_amount, default: 0, null: false
      t.integer :starting_amount, default: 0, null: false
      t.date :end_after, null: false

      t.timestamps
    end
  end
end
