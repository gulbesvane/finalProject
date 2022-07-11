class AddAdminToUsers < ActiveRecord::Migration[7.0]
  def change
    # add new column called admin to the users table with the default value set false
    add_column :users, :admin, :boolean, default: false
  end
end
