class DropBodyFromJobapps < ActiveRecord::Migration
  def up
	remove_column :jobapps, :body
  end

  def down
  end
end
