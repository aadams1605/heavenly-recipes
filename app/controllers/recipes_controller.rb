class RecipesController < ApplicationController
  skip_before_action :authenticate_user!, only: :index

  def index
    if params[:query].present?
      @recipes = Recipe.search_by_recipe(params[:query])
    else
      @recipes = Recipe.all.shuffle.first(3)
      @trending_categories = Category.all.shuffle.first(4)
      @explore_more = (Category.all - @trending_categories).shuffle.first(6)
      @explore_more_buttons = (Category.all - @trending_categories).shuffle.first(4)
    end

    @no_results = @recipes.empty?
  end

  def show
    @recipe = Recipe.find(params[:id])
    #@recipe.ingredients = @recipe.ingredients.split(',') if @recipe.ingredients.is_a?(String)
    @current_user_ratings_count = current_user.ratings.where(recipe_id: @recipe.id).count
    @total_ratings_count = @recipe.ratings.count
    @average_rating = @recipe.ratings.average(:value)
  end
end
