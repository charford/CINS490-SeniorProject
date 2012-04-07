class AddPhotoFileNameToReferences < ActiveRecord::Migration
  def change
    add_column :references, :photo_file_name, :string

  end
end
