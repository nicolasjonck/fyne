class SwipesController < ApplicationController
  def index
    @swipes = Swipe.where(user: current_user).where(interested: true)
  end
end
