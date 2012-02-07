class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :name
      t.text :description
      t.text :requirements
      t.integer :hiring_manager_id

      t.timestamps
    end
  end
end
