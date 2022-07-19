class CreateCollabs < ActiveRecord::Migration[7.0]
  def change
    create_table :collabs do |t|
      t.string :title
      t.string :body
      t.integer :participants, default: 0

      t.timestamps
    end
  end
end
