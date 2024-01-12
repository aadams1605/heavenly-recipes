class CategoriesController < ApplicationController
  def show
    @query_id = params[:id]
    @search_recipe_data = fetch_search_recipe_data(@query_id)

    @category_id = params[:id]
    @category_data = fetch_category(@category_id)

    render 'show'
  end

  private

  def fetch_search_recipe_data(query_id)
    url = "https://www.themealdb.com/api/json/v1/1/lookup.php?i=#{query_id}"

    response = RestClient.get(url)
    data = JSON.parse(response.body)

    if data['meals'] && data['meals'].length > 0
      data['meals'].map do |meal_data|
        {
          id: meal_data['idMeal'],
          name: meal_data['strMeal'],
          photo: meal_data['strMealThumb'],
          category: meal_data['strCategory'],
          instructions: meal_data['strInstructions']
        }
      end
    else
      []
    end
  rescue RestClient::ExceptionWithResponse => e
    puts "Error fetching meal data: #{e.response}"
    []
  end

  def fetch_category(category_id)
    url = "https://www.themealdb.com/api/json/v1/1/categories.php"

    response = RestClient.get(url)
    data = JSON.parse(response.body)

    category_data = data['categories'].find { |category| category['idCategory'] == category_id }

    if category_data
      {
        id: category_data['idCategory'],
        photo: category_data['strCategoryThumb'],
        category: category_data['strCategory']
      }
    else
      nil  # Return nil if category with specified ID is not found
    end
  end

end
