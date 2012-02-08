class Rename < ActiveRecord::Migration
  def up
	rename_table :applicant_comments, :comments
  end

  def down
  end
end
