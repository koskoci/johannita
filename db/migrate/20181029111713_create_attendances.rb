class CreateAttendances < ActiveRecord::Migration[5.2]
  def change
    create_table :attendances do |t|
      t.references :course_event, foreign_key: true
      t.references :participant, foreign_key: true

      t.timestamps
    end
  end
end
