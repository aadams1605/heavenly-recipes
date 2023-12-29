class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
  end

  def about
  end

  def contact
  end

  def search
    @query = params[:query]
    @meal_data = fetch_meal_data(@query)
    render 'search'
  end

  private

  def fetch_meal_data(user_input)
    url = "https://www.themealdb.com/api/json/v1/1/search.php?s=#{user_input}"

    response = RestClient.get(url)
    data = JSON.parse(response.body)

    if data['meals'] && data['meals'].length > 0
      data['meals'].map do |meal_data|
        {
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
