class CreateConfirmations < ActiveRecord::Migration
  def change
    create_table :confirmations do |t|
      t.integer :user_id
      t.string :hash

      t.timestamps
    end
  end
end
