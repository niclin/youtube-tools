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

  def edit
    @donate_event = current_user.donate_events.find_by_token(params[:id])
  end

  def update
    @donate_event = current_user.donate_events.find_by_id(params[:id])

    if @donate_event.update(donate_params)
      redirect_to donate_events_path
    else
      render :edit
    end
  end

  def show
    token = params[:id]

    @donate_event = DonateEvent.find_by_token(token)

    @percentage = (@donate_event.total_amount.to_f / @donate_event.goal_amount.to_f) * 100

    gon.push({
      donate_event_token: token
    })

    render layout: "donate"
  end

  private

  def donate_params
    params.require(:donate_event).permit(:title, :goal_amount, :total_amount, :starting_amount, :end_after)
  end
end
