class CreateActiveusers < ActiveRecord::Migration
  def change
    create_table :activeusers do |t|
      t.integer :user_id

      t.timestamps
    end
  end
end
