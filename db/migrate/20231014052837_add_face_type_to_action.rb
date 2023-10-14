class AddFaceTypeToAction < ActiveRecord::Migration[6.1]
  def change
    add_column :actions, :face_type, :string
  end
end
