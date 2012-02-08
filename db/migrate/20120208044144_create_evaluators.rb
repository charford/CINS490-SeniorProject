class CreateEvaluators < ActiveRecord::Migration
  def change
    create_table :evaluators do |t|
      t.integer :user_id

      t.timestamps
    end
  end
end
