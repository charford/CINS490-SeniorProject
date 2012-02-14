class AddChoiceDToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :choice_d, :string

  end
end
