class RenameEventCToCourseC < ActiveRecord::Migration[5.2]
  def change
    rename_table :event_categories, :course_categories
    add_column :course_categories, :title, :string
    add_column :course_categories, :prerequisite_course_category_id, :integer
    change_column_null :course_categories, :category, false
    rename_column :events, :event_category_id, :course_category_id
  end
end
