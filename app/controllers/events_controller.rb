class EventsController < ApplicationController
  def new
    @event = Event.new
  end

  def create
    @event = current_user.created_events.build(event_params)
    if @event.save
      flash[:success] = 'Created event!'
      redirect_to events_path
    else
      flash[:danger] = 'Failed to create event'
      render :new
    end
  end

  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
  end

  def destroy
    if @event.destroy
      flash[:success] = 'Deleted!'
      redirect_to events_path
    else
      flash[:danger] = 'Failed to delete'
      render @event
    end
  end

  private

  def event_params
    params.require(:event).permit(:title, :description, :location, :date, :time)
  end
end
