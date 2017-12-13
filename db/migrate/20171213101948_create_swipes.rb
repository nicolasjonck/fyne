class CreateSwipes < ActiveRecord::Migration[5.0]
  def change
    create_table :swipes do |t|
      t.references :user, foreign_key: true
      t.references :event, foreign_key: true
      t.boolean :interested

      t.timestamps
    end
  end
end
