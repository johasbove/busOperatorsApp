class CreateBusOperators < ActiveRecord::Migration[5.1]
  def change
    create_table :bus_operators do |t|
      t.integer :external_id
      t.string :internal_name
      t.string :official_name
      t.boolean :bookable
      t.string :phone
      t.boolean :allows_e_ticketing
      t.float :average_rating
      t.text :description
      t.json :payload

      t.timestamps
    end
  end
end
