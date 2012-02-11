class AddPreferredQualificationsToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :preferred_qualifications, :text

  end
end
