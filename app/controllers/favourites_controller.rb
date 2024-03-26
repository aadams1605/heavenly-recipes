class FavouritesController < ApplicationController
  before_action :authenticate_user!

  def index
    @favourite_recipes = current_user.favourites
    @average_ratings = @favourite_recipes.map { |favourite| [favourite.recipe.id, favourite.recipe.ratings.average(:value)] }.to_h
  end

  def create
    if current_user.favourites.exists?(recipe_id: params[:recipe])
      current_user.favourites.find_by(recipe_id: params[:recipe]).destroy
    else
      favourite = Favourite.new(user_id: current_user.id, recipe_id: params[:recipe])
      favourite.save
    end
  end

  def destroy
    favourite = current_user.favourites.find_by(id: params[:id])
    favourite.destroy
    redirect_to favourite_path
  end
end
