class AddPositionToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :position, :string

  end
end
