class CreateLotteryResults < ActiveRecord::Migration[6.1]
  def change
    create_table :lottery_results do |t|
      t.integer :donate_event_id
      t.integer :lottery_id
      t.boolean :is_show

      t.timestamps
    end
  end
end
