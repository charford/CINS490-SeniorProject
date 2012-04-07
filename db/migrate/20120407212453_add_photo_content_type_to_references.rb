class AddPhotoContentTypeToReferences < ActiveRecord::Migration
  def change
    add_column :references, :photo_content_type, :string

  end
end
