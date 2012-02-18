class AddReferenceHashToUser < ActiveRecord::Migration
  def change
    add_column :users, :reference_hash, :string

  end
end
