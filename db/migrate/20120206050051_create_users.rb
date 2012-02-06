class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :username
      t.string :salt
      t.string :encrypted_password
      t.string :user_type

      t.timestamps
    end
  end
end
