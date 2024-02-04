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

20.times do
  url = "https://www.themealdb.com/api/json/v1/1/random.php"
  response = RestClient.get(url)
  data = JSON.parse(response.body)

  category = Category.new(title: data['meals'][0]['strCategory'], photo_url: data['meals'][0]['strMealThumb'])

  if(!(existing_categories.include?(category.title)))
    category.save
    existing_categories.push(category.title)
    recipe = Recipe.new(title: data['meals'][0]['strMeal'], instructions: data['meals'][0]['strInstructions'], photo_url: data['meals'][0]['strMealThumb'], category_id: category.id)
    recipe.save
  else
    category_id = Category.where(title: category.title)[0].id
    recipe = Recipe.new(title: data['meals'][0]['strMeal'], instructions: data['meals'][0]['strInstructions'], photo_url: data['meals'][0]['strMealThumb'], category_id: category_id)
    recipe.save
  end
end
