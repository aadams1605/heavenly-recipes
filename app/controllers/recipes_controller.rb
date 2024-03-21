class RecipesController < ApplicationController
  skip_before_action :authenticate_user!, only: :index

  def index
    @trending_categories = Category.all.shuffle.first(4)
    @explore_more = (Category.all - @trending_categories).shuffle.first(5)
    @explore_more_buttons = (Category.all - @trending_categories - @explore_more).shuffle.first(4)

    if params[:query].present?
      @recipes = Recipe.search_by_recipe(params[:query])
    else
      @recipes = Recipe.all.shuffle.first(3)
    end

    @no_results = @recipes.empty?
  end

  def show
    @recipe = Recipe.find(params[:id])
    @current_user_ratings_count = current_user.ratings.where(recipe_id: @recipe.id).count
    @total_ratings_count = @recipe.ratings.count
    @average_rating = @recipe.ratings.average(:value)
  end
end
