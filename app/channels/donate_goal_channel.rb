class DonateGoalChannel < ApplicationCable::Channel
  def subscribed
    donate_event = DonateEvent.find_by_token(params[:token])
    stream_from "donate_goal_channel_#{donate_event.token}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
