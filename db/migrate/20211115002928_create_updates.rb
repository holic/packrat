class CreateUpdates < ActiveRecord::Migration[7.0]
  def change
    create_table :updates do |t|
      t.references :project, null: false, foreign_key: true
      t.string :title
      t.text :body
      t.string :category
      t.datetime :deadline_at
      t.datetime :publish_at
      t.string :status

      t.timestamps
    end
  end
end
