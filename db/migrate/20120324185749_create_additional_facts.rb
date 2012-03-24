class CreateAdditionalFacts < ActiveRecord::Migration
  def change
    create_table :additional_facts do |t|
      t.integer :evaluator_id
      t.integer :applicant_id
      t.string :fact

      t.timestamps
    end
  end
end
