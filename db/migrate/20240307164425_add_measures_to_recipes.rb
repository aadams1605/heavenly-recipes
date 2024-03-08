class AddMeasuresToRecipes < ActiveRecord::Migration[7.1]
  def change
    add_column :recipes, :measures, :text
  end
end
