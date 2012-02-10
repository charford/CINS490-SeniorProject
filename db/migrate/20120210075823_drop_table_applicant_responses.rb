class DropTableApplicantResponses < ActiveRecord::Migration
  def up
	drop_table :applicant_responses
	drop_table :applicant_questions
  end

  def down
  end
end
