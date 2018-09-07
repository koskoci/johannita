class AddApplyByToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :apply_by, :date
  end
end
