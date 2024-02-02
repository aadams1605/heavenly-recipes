class FavouritesController < ApplicationController
  before_action :authenticate_user!

  def index
    @favourite_recipes = current_user.favourites.map { |favourite| fetch_recipe_data(favourite.recipe_id) }.compact
  end

  def create
    favourite = Favourite.new(user_id: current_user, recipe_id: params[:recipe])
    favourite.save
  end
end
