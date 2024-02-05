class CategoriesController < ApplicationController
  def show
    @category = Category.find_by(title: params[:title].capitalize)
    @recipes = Recipe.where(category_id: @category.id)
  end
end
