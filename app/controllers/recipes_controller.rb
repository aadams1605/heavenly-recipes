class RecipesController < ApplicationController
  skip_before_action :authenticate_user!, only: :index

  def index
    @recipes = Recipe.all.shuffle.first(4)
    @categories = Category.all
    @trending_categories = @categories.shuffle.first(4)
    @explore_more = (Category.all - @trending_categories).shuffle.first(6)
  end

  def show
    @recipe = Recipe.find_by(title: params[:title].gsub("-"," "))
  end
end
