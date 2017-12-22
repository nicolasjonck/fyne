class SwipesController < ApplicationController
  def index
    if params[:query] == nil
      @swipes_liked = Swipe.where(user: current_user).where(interested: true)
    else
      @swipes_liked = Swipe.where(user: current_user).where(interested: true).joins(:event).where(events: {name: params[:query]})
    end

    # Each swipe.event - retreive the date
      @events_liked = @swipes_liked.map { |swipe| swipe.event }
      @array_of_dates = @events_liked.map { |event| event.start_time }.sort.map{|date| date.strftime('%A %dth, %b %Y') }.uniq
  end

  def new
    @swipes = Swipe.where(user: current_user)
    # all the swipes for the current_used (both true and false)

    array_of_swiped_events = []
    (0...@swipes.count).each do |index|
      array_of_swiped_events << @swipes[index].event_id
    end
    # array_of_swiped_events contains the ids of the events already swiped

    @events = Event.where.not(id: array_of_swiped_events).where(city: current_user.city)
    if @events == []
      EventService.new(city: current_user.city, size: 20).call
      @events = Event.where.not(id: array_of_swiped_events).where(city: current_user.city)
    end
    # @events contains all the events that have not been swiped by the user

    @event = @events.sample
    # @event contains a random event selected in the @events array of "not swiped yet" events by the current_user

    # if @event == nil
    #   EventService.new(city: current_user.city).call
    # end

    @swipe = Swipe.new
    @marker = Gmaps4rails.build_markers(@event) do |event, marker|
      marker.lat event.latitude
      marker.lng event.longitude
    end
  end

  def create
    @swipes = Swipe.where(user: current_user)
    # all the swipes for the current_used (both true and false)

    array_of_swiped_events = []
    (0...@swipes.count).each do |index|
      array_of_swiped_events << @swipes[index].event_id
    end
    # array_of_swiped_events contains the ids of the events already swiped

    @events = Event.where.not(id: array_of_swiped_events).where(city: current_user.city)
    if @events == []
      EventService.new(city: current_user.city, size: 20).call
      @events = Event.where.not(id: array_of_swiped_events).where(city: current_user.city)
    end
    # @events contains all the events that have not been swiped by the user

    @event = @events.sample
    # @event contains a random event selected in the @events array of "not swiped yet" events by the current_user

    # if @event == nil
    #   EventService.new(city: current_user.city).call
    # end
      @marker = Gmaps4rails.build_markers(@event) do |event, marker|
      marker.lat event.latitude
      marker.lng event.longitude
    end

    @swipe = Swipe.new(swipe_params)
    @swipe.user = current_user
    # Add it to the user array <<
    if @swipe.save
      respond_to do |format|
        format.js
        format.html { redirect_to new_swipe_path }
      end
    else
      respond_to do |format|
        format.js
        format.html { render :new }
      end
    end
  end

  private

  def swipe_params
    params.require(:swipe).permit(:interested, :event_id, :user_id)
  end

end
