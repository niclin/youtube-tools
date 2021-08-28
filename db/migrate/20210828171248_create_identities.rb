class CreateIdentities < ActiveRecord::Migration[6.1]
  def change
    create_table :identities do |t|
      t.references :user, null: false, foreign_key: true
      t.string :provider
      t.string :uid
      t.string :token
      t.string :refresh_token
      t.integer :expires_at_unix

      t.timestamps
    end
  end
end
