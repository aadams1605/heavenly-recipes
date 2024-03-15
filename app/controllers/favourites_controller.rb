class FavouritesController < ApplicationController
  before_action :authenticate_user!

  def index
    @favourite_recipes = current_user.favourites

    @average_ratings = {}

    @favourite_recipes.each do |fav|
      @average_ratings[fav.recipe.id] = fav.recipe.ratings.average(:value)
    end
  end

  def create
    favourite = Favourite.new(user_id: current_user.id, recipe_id: params[:recipe])
    favourite.save

  #  respond_to do |format|
   #   format.html { head :no_content }
    #  format.js   { head :no_content }
 #   end
  end
end
