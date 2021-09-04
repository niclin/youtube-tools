class DonateEvent < ApplicationRecord
  belongs_to :user
  has_many :lotteries
  has_many :lottery_results

  enum status: {
    enable: 0,
    disable: 1
  }

  before_create :generate_token

  after_commit :broadcast_goal!

  private

  def generate_token
    self.token = SecureRandom.hex(6)
  end

  def broadcast_goal!
    ActionCable.server.broadcast("donate_goal_channel_#{token}", goal_amount: goal_amount, total_amount: total_amount)
  end
end
