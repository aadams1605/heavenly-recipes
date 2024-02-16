class RemoveUserIdFromRatings < ActiveRecord::Migration[7.1]
  def change
    remove_column :ratings, :user_id, :bigint
  end
end
