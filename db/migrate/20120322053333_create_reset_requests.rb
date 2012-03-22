class CreateResetRequests < ActiveRecord::Migration
  def change
    create_table :reset_requests do |t|
      t.integer :user_id
      t.string :request_hash

      t.timestamps
    end
  end
end
