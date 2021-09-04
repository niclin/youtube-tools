class AddEventsUuid < ActiveRecord::Migration[6.1]
  def change
    add_column :donate_events, :token, :string, unique: true
  end
end
