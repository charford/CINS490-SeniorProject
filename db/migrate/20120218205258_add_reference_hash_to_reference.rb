class AddReferenceHashToReference < ActiveRecord::Migration
  def change
    add_column :references, :reference_hash, :string

  end
end
