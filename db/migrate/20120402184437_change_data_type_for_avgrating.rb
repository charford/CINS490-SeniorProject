class ChangeDataTypeForAvgrating < ActiveRecord::Migration
  def up
    change_table :applicants do |t|
      t.change :avgrating, :float
    end
  end

  def down
    change_table :applicants do |t|
      t.change :avgrating, :integer
    end
  end
end
