class CreatePages < ActiveRecord::Migration[5.2]
  def change
    create_table :pages do |t|
      t.string :short_name
      t.text :content

      t.index :short_name, unique: true
    end
  end
end
