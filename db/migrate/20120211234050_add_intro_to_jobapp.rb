class AddIntroToJobapp < ActiveRecord::Migration
  def change
    add_column :jobapps, :intro, :text

  end
end
