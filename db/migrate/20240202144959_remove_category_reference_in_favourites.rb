class RemoveCategoryReferenceInFavourites < ActiveRecord::Migration[7.1]
  def change
    remove_reference :favourites, :category
  end
end
