class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.integer :question_id
      t.integer :applicant_id
      t.text :body

      t.timestamps
    end
  end
end
