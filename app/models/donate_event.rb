class DonateEvent < ApplicationRecord
  belongs_to :user

  enum status: {
    enable: 0,
    disable: 1
  }

  after_commit :broadcast_goal!

  private

  def broadcast_goal!
    ActionCable.server.broadcast("donate_goal_channel_#{id}", goal_amount: goal_amount, total_amount: total_amount)
  end
end
