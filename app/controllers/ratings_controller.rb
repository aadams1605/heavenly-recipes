class RatingsController < ApplicationController
  def index
    @rated_recipes = current_user.ratings
  end

  def create
    @recipe = Recipe.find(params[:recipe_id])
    @rating = Rating.new(value: params[:value], recipe_id: @recipe.id, user_id: current_user.id)

      if @rating.save
        redirect_to recipe_path(@recipe)
      else
        redirect_to recipe_path(@recipe)
      end
  end
end
