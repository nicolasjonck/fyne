class EventsController < ApplicationController
  before_action :set_event, only:[:show, :edit, :update, :destroy]
  before_action :set_user, only:[:show, :new, :create, :edit, :update, :destroy]

  def index
    @group_of_events = Event.all
    # .order(start_time: :asc).group("DATE_TRUNC('day', start_time)")
    #Afterwards, need to do where swipe.interested = true or where swipe.event.user = current_user
  end

  def show
    # event = EventService.new.call
    #afterwards, need to do booking

    # add when latitude and long added to event model:
    # @event = Event.where.not(latitude: nil, longitude: nil)

    # @markers = Gmaps4rails.build_markers(@event) do |event, marker|
    #   marker.lat event.latitude
    #   marker.lng event.longitude
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.user = current_user
    current_user.save
    if @event.save
      flash[:success] = "Congrats, your event #{@event.name} has been created!"
      redirect_to event_path(@event)
    else
      render :new
    end
  end

  def edit
    @user = current_user
    @event = Event.find(params[:id])
  end

  def update
    @event.update(event_params)
    @event.save
    if @event.save
      flash[:success] = "Your event #{@event.name} has been successfully updated"
      redirect_to event_path(@event)
    else
      render :edit
    end
  end

  def destroy
    @event.destroy
    flash[:success] = "Your event has been successfully deleted"
    redirect_to root_path
  end


  private

  def event_params
    params.require(:event).permit(:name, :user, :category, :subcategory, :start_time, :end_time, :street_address, :city, :zip_code, :state, :country, photos: [])
  end

  def set_event
    @event = Event.find(params[:id])
  end

  def set_user
    @user = current_user
  end

end
