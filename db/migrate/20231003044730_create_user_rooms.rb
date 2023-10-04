class CreateUserRooms < ActiveRecord::Migration[6.1]
  def change
    create_table :user_rooms do |t|
      t.references :user, null: false, foreign_key: true
      t.string :room
      t.string :references

      t.timestamps
    end
  end
end
