class AddBlurbToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :blurb, :string
  end
end
