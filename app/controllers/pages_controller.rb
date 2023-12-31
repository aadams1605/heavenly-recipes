class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :index

  def about
  end

  def contact
  end

  def index
    @random_recipe_data = fetch_random_recipe_data
    @random_category_data = fetch_random_recipe_data
    @further_category_data = fetch_further_categories
    render 'index'
  end

  def search
    @query = params[:query]
    @search_recipe_data = fetch_search_recipe_data(@query)
    render 'search'
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


  def fetch_random_recipe_data(num_meals = 4)
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

  def fetch_further_categories(num_categories = 6)
    url = "https://www.themealdb.com/api/json/v1/1/categories.php"

    all_categories = []

    num_categories.times do
      response = RestClient.get(url)
      data = JSON.parse(response.body)

      all_categories += data['categories']
    end

    unique_categories = all_categories.shuffle.uniq { |category_data| category_data['idCategory'] }
      .map do |category_data|
        {
          id: category_data['idCategory'],
          photo: category_data['strCategoryThumb'],
          category: category_data['strCategory']
        }
      end

    unique_categories.take(num_categories)
  end
end
