class DropUserTypeFromUsers < ActiveRecord::Migration
  def up
	remove_column :users, :user_type
  end

  def down
  end
end
