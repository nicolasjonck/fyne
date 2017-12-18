class AddPhotouploadedToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :photouploaded, :string
  end
end
