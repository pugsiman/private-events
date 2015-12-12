class EventsController < ApplicationController
  before_action :logged_in_user, only: [:create, :new]

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
    @upcoming_events = Event.upcoming.paginate(page: params[:upcoming_events], per_page: 3)
    @past_events = Event.past.paginate(page: params[:past_events], per_page: 3)
  end

  def show
    @event = Event.find(params[:id])
  end

  def destroy
    @event = Event.find(params[:id])
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
