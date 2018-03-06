class CreateReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      t.string :comment
      t.float :rating
      t.references :bus_operator, index: true, null: false

      t.timestamps
    end
  end
end
