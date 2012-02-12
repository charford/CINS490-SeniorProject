class CreateJobapps < ActiveRecord::Migration
  def change
    create_table :jobapps do |t|
      t.integer :job_id
      t.text :body

      t.timestamps
    end
  end
end
