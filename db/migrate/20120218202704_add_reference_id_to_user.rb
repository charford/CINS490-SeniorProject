class AddReferenceIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :reference_id, :integer

  end
end
