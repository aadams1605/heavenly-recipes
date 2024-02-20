class RatingsController < ApplicationController
  def index
    @rated_recipes = current_user.ratings
  end

  def create
    rating = Rating.new(user_id: current_user.id, recipe_id: params[:recipe], value: params[:value])
    rating.save
  end
end
