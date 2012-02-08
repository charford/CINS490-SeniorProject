class CreateApplicantComments < ActiveRecord::Migration
  def change
    create_table :applicant_comments do |t|
      t.integer :applicant_id
      t.integer :user_id
      t.text :body

      t.timestamps
    end
  end
end
