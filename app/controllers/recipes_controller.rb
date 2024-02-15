class RecipesController < ApplicationController
  skip_before_action :authenticate_user!, only: :index

  def index
    if params[:query].present?
      @recipes = Recipe.search_by_recipe(params[:query])
    else
      @recipes = Recipe.all.shuffle.first(4)
      @categories = Category.all
      @trending_categories = @categories.shuffle.first(4)
      @explore_more = (Category.all - @trending_categories).shuffle.first(6)
    end
  end

  def show
    @recipe = Recipe.find(params[:id])
  end
end
