class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
  end

  def swipes
    @swipes_liked = Swipe.where(user: current_user).where(interested: true)
  end

  def profile
    @user = current_user
  end
end
