class RatingsController < ApplicationController
  def index
    @rated_recipes = current_user.ratings
  end

  def create
    rating = Rating.new(recipe_id: params[:recipe], value: params[:value])
  end
end
