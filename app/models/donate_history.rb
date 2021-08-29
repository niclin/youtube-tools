class DonateHistory < ApplicationRecord
  belongs_to :user

  after_create :update_event!

  private

  def update_event!
    event = user.donate_events.enable.first

    return if event.blank?

    total_amount = DonateHistory.where(user: user, donate_at: event.created_at..event.end_after.end_of_day).sum(:amount_micros) / 1000000

    event.update!(total_amount: total_amount)
  end

  def amount
    amount_micros / 1000000
  end
end
