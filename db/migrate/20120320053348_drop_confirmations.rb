class DropConfirmations < ActiveRecord::Migration
  def up
  drop_table :confirmations
  end

  def down
  end
end
