class AddPostFk < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :user_id, :integer
    remove_foreign_key :users, column: :profile_id
  end
end
