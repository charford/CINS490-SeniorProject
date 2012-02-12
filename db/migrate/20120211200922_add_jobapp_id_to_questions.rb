class AddJobappIdToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :jobapp_id, :integer

  end
end
