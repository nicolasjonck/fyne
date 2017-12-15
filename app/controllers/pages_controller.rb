class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]
  before_action :set_swipes, only: [:profile]

  def home
  end

  def profile
    @user = current_user
    @percentage_liked = 100 * (@swipes_liked / @swipes)

  end

  private

  def set_swipes
    @swipes_liked = Swipe.where(user: current_user).where(interested: true).count.to_f
    @swipes = Swipe.where(user: current_user).count.to_f
  end

end
