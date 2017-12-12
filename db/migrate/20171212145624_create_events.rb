class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.string :name
      t.string :category
      t.string :subcategory
      t.date :start_time
      t.date :end_time
      t.string :photo
      t.string :street_address
      t.string :city
      t.string :zip_code
      t.string :state
      t.string :country
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
