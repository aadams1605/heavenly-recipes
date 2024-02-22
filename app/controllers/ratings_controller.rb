class RatingsController < ApplicationController
  def index
    @rated_recipes = current_user.ratings
  end

  # def create
  #   @recipe = Recipe.find(params[:id])
  #   @rating = @recipe.recipe_id(value: params[:value])

  #   if @rating.save
  #     redirect_to recipe_path(@recipe), notice: "Rating added successfully!"
  #   else
  #     redirect_to recipe_path(@recipe), alert: "Failed to add rating."
  #   end
  # end
end
