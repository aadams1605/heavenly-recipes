# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# recipe1 = { title: "Spicy Mango Delight", instructions: "Mix diced mango with chili powder and serve chilled." }
# recipe2 = { title: "Lemon Herb Explosion", instructions: "Marinate chicken in lemon, thyme, and rosemary. Grill to perfection." }
# recipe3 = { title: "Savory Mushroom Medley", instructions: "Sauté mushrooms with garlic and onions. Season with salt and pepper." }
# recipe4 = { title: "Crispy Tofu Surprise", instructions: "Coat tofu in breadcrumbs and bake until golden. Serve with soy-ginger sauce." }
# recipe5 = { title: "Maple Bacon Bliss", instructions: "Wrap bacon around asparagus and drizzle with maple syrup. Bake until crispy." }
# recipe6 = { title: "Quinoa Fiesta Bowl", instructions: "Combine cooked quinoa with black beans, corn, and salsa. Top with avocado." }
# recipe7 = { title: "Zesty Orange Salmon", instructions: "Marinate salmon in orange juice, ginger, and soy sauce. Grill until flaky." }
# recipe8 = { title: "Cheesy Spinach Stuffed Chicken", instructions: "Stuff chicken breasts with spinach and feta. Bake until cheese is melted." }
# recipe9 = { title: "Pesto Pasta Perfection", instructions: "Toss cooked pasta with homemade basil pesto and cherry tomatoes." }
# recipe10 = { title: "Berrylicious Smoothie Bowl", instructions: "Blend mixed berries, banana, and yogurt. Top with granola and coconut." }
# recipe11 = { title: "Mango Tango Chicken", instructions: "Grill chicken with a mango glaze until it's golden brown and juicy." }
# recipe12 = { title: "Garlic Rosemary Shrimp", instructions: "Sauté shrimp in garlic and rosemary-infused olive oil until pink and flavorful." }
# recipe13 = { title: "Caprese Salad Stack", instructions: "Layer fresh tomatoes, mozzarella, and basil. Drizzle with balsamic glaze." }
# recipe14 = { title: "Honey Mustard Glazed Carrots", instructions: "Roast carrots with a honey mustard glaze until they're caramelized and tender." }
# recipe15 = { title: "Pineapple Teriyaki Tofu", instructions: "Marinate tofu in pineapple teriyaki sauce and stir-fry until crispy." }
# recipe16 = { title: "Cajun Cauliflower Bites", instructions: "Coat cauliflower florets in Cajun seasoning and bake until golden and crunchy." }
# recipe17 = { title: "Avocado Lime Cilantro Rice", instructions: "Mix cooked rice with diced avocado, lime juice, and fresh cilantro." }
# recipe18 = { title: "Sun-dried Tomato Pesto Pizza", instructions: "Spread sun-dried tomato pesto on pizza dough and top with your favorite ingredients." }
# recipe19 = { title: "Blueberry Almond Pancakes", instructions: "Make fluffy pancakes with blueberries and top with sliced almonds and maple syrup." }
# recipe20 = { title: "Mediterranean Chickpea Salad", instructions: "Combine chickpeas, cherry tomatoes, cucumber, and feta. Dress with olive oil and lemon." }

# Recipe.create!(recipes)

Favourite.destroy_all
Recipe.destroy_all
Category.destroy_all

existing_categories = []

20.times do
  url = "https://www.themealdb.com/api/json/v1/1/random.php"
  response = RestClient.get(url)
  data = JSON.parse(response.body)

  category = Category.new(title: data['meals'][0]['strCategory'])

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

  puts "Recipe created"
end
