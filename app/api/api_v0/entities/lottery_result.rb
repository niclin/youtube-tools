module ApiV0
  module Entities
    class LotteryResult < Entities::Base
      expose :lottery_id
      expose :is_show
    end
  end
end
