class CreateCategories < ActiveRecord::Migration[7.1]
  def change
    create_table :categories do |t|
      t.string :title
      t.text :description
      t.string :photo_url

      t.timestamps
    end
  end
end
