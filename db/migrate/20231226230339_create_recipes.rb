class CreateRecipes < ActiveRecord::Migration[7.1]
  def change
    create_table :recipes do |t|
      t.string :title
      t.text :description
      t.text :instructions
      t.string :photo_url
      t.references :category, null: false, foreign_key: true
      t.text :ingredients
      t.text :nutrition_information

      t.timestamps
    end
  end
end
