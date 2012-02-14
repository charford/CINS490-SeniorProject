class AddChoiceAToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :choice_a, :string

  end
end
