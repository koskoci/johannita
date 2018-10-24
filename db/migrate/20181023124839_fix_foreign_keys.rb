class FixForeignKeys < ActiveRecord::Migration[5.2]
  def change
    remove_reference :course_events, :course_category, null: false, foreign_key: true
    add_reference :course_events, :course, null: false, foreign_key: true

    remove_reference :participants, :course_event, null: false, foreign_key: true
    add_reference :participants, :course, null: false, foreign_key: true, index: true
    add_index(:participants, [:course_id, :user_id], unique: true, name: 'idx_course_user_unique')
  end
end
