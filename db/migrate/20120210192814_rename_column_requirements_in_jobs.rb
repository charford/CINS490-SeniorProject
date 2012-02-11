class RenameColumnRequirementsInJobs < ActiveRecord::Migration
  def up
	rename_column :jobs, :requirements, :minimum_qualifications
  end

  def down
  end
end
