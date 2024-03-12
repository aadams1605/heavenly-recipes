class UpdateRecipesMeasuresToArray < ActiveRecord::Migration[7.1]
  def change
    remove_column :recipes, :measures
    add_column :recipes, :measures, :text, array: true, default: []
  end
end
