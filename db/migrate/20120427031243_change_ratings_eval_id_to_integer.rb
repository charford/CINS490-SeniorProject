class ChangeRatingsEvalIdToInteger < ActiveRecord::Migration
  def up
    change_table :ratings do |t|
      t.change :evaluator_id, :integer
    end
  end

  def down
  end
end
