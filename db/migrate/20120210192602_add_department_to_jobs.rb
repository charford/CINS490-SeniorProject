class AddDepartmentToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :department, :text

  end
end
