class CreateProjects < ActiveRecord::Migration[7.0]
  def change
    create_table :projects do |t|
      t.string :name
      t.string :url_opensea
      t.string :url_discord
      t.string :url_twitter
      t.string :url_website
      t.text :description
      t.string :slug
      t.string :image_avatar_url

      t.timestamps
    end
  end
end
