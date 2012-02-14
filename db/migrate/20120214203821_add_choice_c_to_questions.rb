class AddChoiceCToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :choice_c, :string

  end
end
