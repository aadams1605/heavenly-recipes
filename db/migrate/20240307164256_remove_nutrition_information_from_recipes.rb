class RemoveNutritionInformationFromRecipes < ActiveRecord::Migration[7.1]
  def change
    remove_column :recipes, :nutrition_information
  end
end
