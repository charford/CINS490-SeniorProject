class AddPublishedToApplicant < ActiveRecord::Migration
  def change
    add_column :applicants, :published, :boolean

  end
end
