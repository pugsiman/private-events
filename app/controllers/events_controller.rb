class EventsController < ApplicationController
  before_action :logged_in_user, only: [:create, :new]
  before_action :event_creator, only:  [:edit, :update, :destroy]
  before_action :find_event, only:     [:edit, :update, :destroy, :show]

  def new
    @event = Event.new
  end

  def create
    @event = current_user.created_events.build(event_params)
    if @event.save
      flash[:success] = 'Created event!'
      redirect_to @event
    else
      flash[:danger] = 'Failed to create event'
      render :new
    end
  end

  def index
    @upcoming_events = Event.upcoming.paginate(page: params[:upcoming_events],
                                               per_page: 3)
    @past_events = Event.past.paginate(page: params[:past_events],
                                       per_page: 3)
  end

  def edit
  end

  def update
    @event.update_attributes(event_params)
    if @event.save
      flash[:success] = 'Updated!'
      redirect_to @event
    else
      flash[:danger] = 'Problem with your form'
      render :edit
    end
  end

  def show
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

  def find_event
    @event = Event.find(params[:id])
  end

  def event_creator
    @event = Event.find(params[:id])
    return if current_user == @event.creator
    flash[:danger] = 'I can\'t let you do that, Dave'
    redirect_to root_url
  end
end
