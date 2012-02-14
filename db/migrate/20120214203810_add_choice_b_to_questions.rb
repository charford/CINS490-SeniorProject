class AddChoiceBToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :choice_b, :string

  end
end
