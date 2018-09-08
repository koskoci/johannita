class CreateEventCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :event_categories do |t|
      t.date :last_date
      t.string :category
      t.timestamps
    end

    remove_column :events, :category, :string
    add_reference :events, :event_category, foreign_key: true
  end
end
