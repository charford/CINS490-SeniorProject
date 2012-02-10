class CreateApplicantQuestions < ActiveRecord::Migration
  def change
    create_table :applicant_questions do |t|
      t.integer :applicant_id
      t.text :question

      t.timestamps
    end
  end
end
