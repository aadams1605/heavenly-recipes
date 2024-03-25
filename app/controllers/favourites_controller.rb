class FavouritesController < ApplicationController
  before_action :authenticate_user!

  def index
    @favourite_recipes = current_user.favourites
    @average_ratings = @favourite_recipes.map { |favourite| [favourite.recipe.id, favourite.recipe.ratings.average(:value)] }.to_h
  end

  def create
    favourite = Favourite.new(user_id: current_user.id, recipe_id: params[:recipe])
    favourite.save

  #  respond_to do |format|
   #   format.html { head :no_content }
    #  format.js   { head :no_content }
 #   end
  end

  def destroy
    favourite = current_user.favourites.find_by(id: params[:id])
    favourite.destroy
    redirect_to favourite_path
  end
end
