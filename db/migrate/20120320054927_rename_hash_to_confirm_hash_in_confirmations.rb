class RenameHashToConfirmHashInConfirmations < ActiveRecord::Migration
  def up
    rename_column :confirmations, :hash, :confirm_hash
  end

  def down
  end
end
