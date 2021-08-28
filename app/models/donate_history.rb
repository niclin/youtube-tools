class DonateHistory < ApplicationRecord
  belongs_to :donate_event

  after_create :update_event!

  private

  def update_event!
    total_amount = donate_event.history.sum(:money)

    donate_event.update!(total_amount: total_amount)
  end
end
