class AddAvgratingToApplicant < ActiveRecord::Migration
  def change
    add_column :applicants, :avgrating, :integer

  end
end
