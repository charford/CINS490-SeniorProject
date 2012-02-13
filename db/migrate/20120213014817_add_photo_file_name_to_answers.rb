class AddPhotoFileNameToAnswers < ActiveRecord::Migration
  def change
    add_column :answers, :photo_file_name, :string

  end
end
