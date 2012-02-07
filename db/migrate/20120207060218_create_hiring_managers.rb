class CreateHiringManagers < ActiveRecord::Migration
  def change
    create_table :hiring_managers do |t|
      t.integer :user_id

      t.timestamps
    end
  end
end
