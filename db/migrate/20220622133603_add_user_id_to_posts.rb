class AddUserIdToPosts < ActiveRecord::Migration[7.0]
  def change
    # this will add a column in posts table with name user_id and values as integers
    add_column :posts, :user_id, :int
  end
end
