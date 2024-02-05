# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Favourite.destroy_all
Recipe.destroy_all
Category.destroy_all

existing_categories = []

until existing_categories.size == 14 do
  url = "https://www.themealdb.com/api/json/v1/1/random.php"
  response = RestClient.get(url)
  data = JSON.parse(response.body)

  category = Category.new(title: data['meals'][0]['strCategory'], photo_url: data['meals'][0]['strMealThumb'])

  if(!(existing_categories.include?(category.title)))
    category.save
    existing_categories.push(category.title)

    response = RestClient.get("https://www.themealdb.com/api/json/v1/1/filter.php?c=#{category.title}")
    data = JSON.parse(response.body)

    if data['meals'] && data['meals'].length > 0
      data['meals'].map do |meal_data|
        meal_url = "www.themealdb.com/api/json/v1/1/lookup.php?i=#{meal_data['idMeal']}"
        meal_response = RestClient.get(meal_url)
        meal_info = JSON.parse(meal_response.body)['meals'].first
        Recipe.create(title: meal_data['strMeal'], instructions: meal_info['strInstructions'], photo_url: meal_data['strMealThumb'], category_id: category.id)
      end
    end
  end
end
