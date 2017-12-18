class AddColumnsToEvent < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :description, :string
    add_column :events, :eventful_id, :string
    add_column :events, :venue_name, :string
    add_column :events, :url, :string
  end
end
