class ChangeDataTypeForAvgratingToDecimalWithPrecision < ActiveRecord::Migration
  def up
    change_table :applicants do |t|
      t.change :avgrating, :decimal,:precision => 8, :scale => 2
    end
  end

  def down
    change_table :applicants do |t|
      t.change :avgrating, :integer
    end
  end
end
