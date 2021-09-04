class DonateEventsController < ApplicationController
  before_action :authenticate_user!, only: [:index]

  def index
    @donate_events = current_user.donate_events
  end

  def new
    @donate_event = current_user.donate_events.new
  end

  def create
    @donate_event = current_user.donate_events.new(donate_params)

    if @donate_event.save
      redirect_to donate_events_path
    else
      render :new
    end
  end

  def show
    @donate_event = DonateEvent.find_by_token(params[:id])
    render layout: "donate"
  end

  private

  def donate_params
    params.require(:donate_event).permit(:title, :goal_amount, :total_amount, :starting_amount, :end_after)
  end
end
