class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :index

  def about
  end

  def contact
  end

  def index
    @meal_data = fetch_random_meal_data
    render 'index'
  end

  def search
    @query = params[:query]
    @meal_data = fetch_search_meal_data(@query)
    render 'search'
  end

  private

  def fetch_search_meal_data(user_input)
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


  def fetch_random_meal_data(num_meals = 4)
    url = "https://www.themealdb.com/api/json/v1/1/random.php"

    meal_data = []

    num_meals.times do
      response = RestClient.get(url)
      data = JSON.parse(response.body)

      meal_data += data['meals'].map do |meal_data|
        {
          id: meal_data['idMeal'],
          name: meal_data['strMeal'],
          photo: meal_data['strMealThumb'],
          category: meal_data['strCategory']
        }
      end
    end
    meal_data
  end
end
