class LotteryResult < ApplicationRecord
  belongs_to :donate_event
  belongs_to :lottery
end
