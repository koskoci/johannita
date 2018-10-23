class AddDefaultToEventStatus < ActiveRecord::Migration[5.2]
  def up
    change_column :events, :status, :string, default: "posted"
  end

  def down
    change_column :events, :status, :string, default: nil
  end
end
