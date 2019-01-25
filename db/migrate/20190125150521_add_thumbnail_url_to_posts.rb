class AddThumbnailUrlToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :thumbnail_url, :string, null: false
  end
end
