class DonateEvent < ApplicationRecord
  has_many :history, class_name: "DonateHistory"

  after_commit :broadcast_goal!

  private

  def broadcast_goal!
    ActionCable.server.broadcast("donate_goal_channel_#{id}", goal_amount: goal_amount, total_amount: total_amount)
  end
end
