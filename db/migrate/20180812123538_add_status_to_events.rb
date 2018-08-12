class AddStatusToEvents < ActiveRecord::Migration[5.2]
  def change
    remove_column :events, :confirmed, :boolean
    add_column :events, :status, :string
  end
end
