class RemoveStateFromEvents < ActiveRecord::Migration[5.0]
  def change
    remove_column :events, :state
  end
end
