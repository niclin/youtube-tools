class DonateHistory < ApplicationRecord
  belongs_to :user

  after_create :update_event!

  has_one :lottery_result

  private

  def update_event!
    event = user.donate_events.enable.first

    return if event.blank?

    lotteries = event.lotteries

    # 先抽獎，在更新 Event，避免前端被 boradcast 之後資料的時間差
    if lotteries.present?
      min_number = lotteries.pluck(:id).min
      max_number = lotteries.pluck(:id).max

      win_lottery = lotteries.find(rand(min_number..max_number))

      create_lottery_result!(lottery: win_lottery, item: win_lottery.item)
    end

    total_amount = DonateHistory.where(user: user, donate_at: event.created_at..event.end_after.end_of_day).sum(:amount_micros) / 1000000

    event.update!(total_amount: total_amount)
  end

  def amount
    amount_micros / 1000000
  end
end
