class SwipesController < ApplicationController
  def index
    @swipes_liked = Swipe.where(user: current_user).where(interested: true)
  end

  def new
    @swipes = Swipe.where(user: current_user)
    # all the swipes for the current_used (both true and false)

    array_of_swiped_events = []
    (0...@swipes.count).each do |index|
      array_of_swiped_events << @swipes[index].event_id
    end
    # array_of_swiped_events contains the ids of the events already swiped

    @events = Event.where.not(id: array_of_swiped_events)
    # @events contains all the events that have not been swiped by the user

    @event = @events.sample
    # @event contains a random event selected in the @events array of "not swiped yet" events by the current_user

    @swipe = Swipe.new
  end

  def create
    @swipe = Swipe.new(swipe_params)
    if @swipe.save
      redirect_to new_swipe_path
    else
      render :new
    end
  end

  private

  def swipe_params
    params.require(:swipe).permit(:interested, :event_id, :user_id)
  end

end
