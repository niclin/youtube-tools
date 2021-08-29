class CreateDonateHistories < ActiveRecord::Migration[6.1]
  def change
    create_table :donate_histories do |t|
      t.integer :user_id
      t.string :currency, null: false
      t.integer :amount_micros, null: false
      t.string :display_name
      t.string :donate_channel_id
      t.string :self_channel_id
      t.integer :message_type
      t.string :uid
      t.string :kind
      t.string :comment
      t.datetime :donate_at

      t.timestamps
    end
  end
end
