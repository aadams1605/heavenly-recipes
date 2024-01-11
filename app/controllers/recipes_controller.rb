class RecipesController < ApplicationController
  def show
    @query = params[:query]
    @search_recipe_data = fetch_search_recipe_data(@query)
    render 'show'
  end

  private

  def fetch_search_recipe_data(user_input)
    url = "https://www.themealdb.com/api/json/v1/1/search.php?s=#{user_input}"

    response = RestClient.get(url)
    data = JSON.parse(response.body)

    if data['meals'] && data['meals'].length > 0
      data['meals'].map do |meal_data|
        {
          id: meal_data['idMeal'],
          name: meal_data['strMeal'],
          photo: meal_data['strMealThumb'],
          category: meal_data['strCategory']
        }
      end
    else
      []
    end
  rescue RestClient::ExceptionWithResponse => e
    puts "Error fetching meal data: #{e.response}"
    []
  end
end
