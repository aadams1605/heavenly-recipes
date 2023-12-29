# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'rest-client'
require 'json'

def fetch_meal_data(user_input)
  url = "https://www.themealdb.com/api/json/v1/1/search.php?s=#{user_input}"

  response = RestClient.get(url)
  data = JSON.parse(response.body)

  if data['meals'] && data['meals'].length > 0
    meal_data = data['meals'][0]
    {
      name: meal_data['strMeal'],
      photo: meal_data['strMealThumb'],
      category: meal_data['strCategory']
    }
  else
    nil
  end
rescue RestClient::ExceptionWithResponse => e
  puts "Error fetching meal data: #{e.response}"
  nil
end
