class HomeController < ApplicationController
  def index
    @donate_event = DonateEvent.first

    if @donate_event.present?
      @percentage = (@donate_event.total_amount.to_f / @donate_event.goal_amount.to_f) * 100
    end
  end
end
