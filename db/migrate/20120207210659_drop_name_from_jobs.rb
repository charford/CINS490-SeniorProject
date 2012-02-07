class DropNameFromJobs < ActiveRecord::Migration
  def up
	remove_column :jobs,:name
  end

  def down
  end
end
