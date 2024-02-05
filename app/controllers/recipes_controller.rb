class RecipesController < ApplicationController
  def index
    @recipes = Recipe.all
    @categories = Category.all
  end

  def show
    @recipe = Recipe.find(params[:id])
  end
end
