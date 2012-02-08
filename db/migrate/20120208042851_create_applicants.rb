class CreateApplicants < ActiveRecord::Migration
  def change
    create_table :applicants do |t|
      t.integer :user_id
      t.integer :job_id

      t.timestamps
    end
  end
end
