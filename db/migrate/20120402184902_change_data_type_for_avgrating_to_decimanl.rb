class ChangeDataTypeForAvgratingToDecimanl < ActiveRecord::Migration
  def up
    change_table :applicants do |t|
      t.change :avgrating, :decimal
    end
  end

  def down
    change_table :applicants do |t|
      t.change :avgrating, :decimal
    end
  end
end
