class AddPhotoFileSizeToReferences < ActiveRecord::Migration
  def change
    add_column :references, :photo_file_size, :string

  end
end
