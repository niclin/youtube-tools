class DonateGoalChannel < ApplicationCable::Channel
  def subscribed
    donate_event = DonateEvent.find(params[:id])
    stream_from "donate_goal_channel_#{donate_event.id}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def donate
    ActionCable.server.broadcast("donate_goal_channel", money: data["money"], name: data["name"], comment: data["comment"])
  end

  def speak(data)
    ActionCable.server.broadcast "donate_goal_channel", message: data["message"], sent_by: data["name"]
  end

  def announce(data)
    ActionCable.server.broadcast "donate_goal_channel", chat_room_name: data["name"], type: data["type"]
  end
end
