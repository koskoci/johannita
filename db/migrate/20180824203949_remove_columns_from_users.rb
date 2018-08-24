class RemoveColumnsFromUsers < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :pav_date, :pav_until
    rename_column :users, :driving_licence_date, :driving_licence_since
    remove_column :users, :pav, :boolean
    remove_column :users, :driving_licence, :boolean
  end
end
