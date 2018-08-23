class AddDetailsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :pav, :boolean
    add_column :users, :pav_date, :date
    add_column :users, :driving_licence, :boolean
    add_column :users, :driving_licence_date, :date
  end
end
