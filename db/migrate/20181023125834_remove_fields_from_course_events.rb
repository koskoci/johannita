class RemoveFieldsFromCourseEvents < ActiveRecord::Migration[5.2]
  def change
    remove_column :course_events, :status, :string
    remove_column :course_events, :apply_by, :date
  end
end
