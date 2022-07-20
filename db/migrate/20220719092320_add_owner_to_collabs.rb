class AddOwnerToCollabs < ActiveRecord::Migration[7.0]
  def change
    add_column :collabs, :owner, :int
  end
end
