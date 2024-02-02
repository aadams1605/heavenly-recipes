class FavouritesController < ApplicationController
  before_action :authenticate_user!

  def index
    @favourite_recipes = current_user.favourites
  end

  def create
    favourite = Favourite.new(user_id: current_user.id, recipe_id: params[:recipe])
    favourite.save
  end
end
