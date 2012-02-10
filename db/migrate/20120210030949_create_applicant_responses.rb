class CreateApplicantResponses < ActiveRecord::Migration
  def change
    create_table :applicant_responses do |t|
      t.integer :applicant_id
      t.text :response

      t.timestamps
    end
  end
end
