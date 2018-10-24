class AddCourses < ActiveRecord::Migration[5.2]
  def change
    create_table :courses do |t|
      t.date :apply_by, null: false
      t.string :title
      t.string :status, null: false, default: "posted"
      t.references :course_category, foreign_key: true, null: false

      t.timestamps
    end
  end
end
