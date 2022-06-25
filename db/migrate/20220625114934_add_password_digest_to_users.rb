class AddPasswordDigestToUsers < ActiveRecord::Migration[7.0]
  def change
    #add a new col to users table named password_digest of type string
    add_column :users, :password_digest, :string
  end
end
