class LotteryResult < ApplicationRecord
  belongs_to :donate_history
  belongs_to :lottery
end
