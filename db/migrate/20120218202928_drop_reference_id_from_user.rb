class DropReferenceIdFromUser < ActiveRecord::Migration
  def up
		remove_column :users, :reference_id
  end

  def down
  end
end
