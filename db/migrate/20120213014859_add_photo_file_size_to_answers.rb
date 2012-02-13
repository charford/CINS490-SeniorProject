class AddPhotoFileSizeToAnswers < ActiveRecord::Migration
  def change
    add_column :answers, :photo_file_size, :string

  end
end
