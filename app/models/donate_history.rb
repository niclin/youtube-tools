class DonateHistory < ApplicationRecord
  belongs_to :user

  after_create :update_event!

  private

  def update_event!
    event = user.donate_events.enable.first

    return if event.blank?

    total_amount = DonateHistory.where(created_at: event.created_at..Time.zone.now).sum(:amount)

    event.update!(total_amount: total_amount)
  end
end
