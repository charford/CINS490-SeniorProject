class CreateReferences < ActiveRecord::Migration
  def change
    create_table :references do |t|
      t.integer :user_id
      t.string :firstname
      t.string :lastname
      t.string :email
      t.string :phone
      t.text :letter

      t.timestamps
    end
  end
end
