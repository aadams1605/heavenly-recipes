class UpdateRecipesIngredientsToArray < ActiveRecord::Migration[7.1]
  def change
    remove_column :recipes, :ingredients
    add_column :recipes, :ingredients, :text, array: true, default: []
  end
end
