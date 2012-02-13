class AddPhotoContentTypeToAnswers < ActiveRecord::Migration
  def change
    add_column :answers, :photo_content_type, :string

  end
end
