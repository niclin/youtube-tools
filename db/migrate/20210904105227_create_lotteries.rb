class CreateLotteries < ActiveRecord::Migration[6.1]
  def change
    create_table :lotteries do |t|
      t.integer :donate_event_id
      t.string :item

      t.timestamps
    end
  end
end
