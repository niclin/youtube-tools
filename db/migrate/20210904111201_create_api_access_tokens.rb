class CreateApiAccessTokens < ActiveRecord::Migration[6.1]
  def change
    create_table :api_access_tokens do |t|
      t.integer :user_id, null: false
      t.string :key, unique: true, null: false
      t.boolean :enable, default: true

      t.timestamps
    end
  end
end
