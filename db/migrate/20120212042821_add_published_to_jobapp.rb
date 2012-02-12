class AddPublishedToJobapp < ActiveRecord::Migration
  def change
    add_column :jobapps, :published, :boolean

  end
end
