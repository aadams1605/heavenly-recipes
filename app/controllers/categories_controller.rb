class CategoriesController < ApplicationController
  def show
    @category = params[:category]
    @category_data = fetch_category_data(@category)
    render 'show'
  end

  private

  def fetch_category_data(query)

    url = "https://www.themealdb.com/api/json/v1/1/filter.php?c=#{query}"

    response = RestClient.get(url)
    data = JSON.parse(response.body)

    if data['meals'] && data['meals'].length > 0
      data['meals'].map do |meal_data|
        {
          id: meal_data['idMeal'],
          name: meal_data['strMeal'],
          photo: meal_data['strMealThumb']
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
