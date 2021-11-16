class CreatePermissions < ActiveRecord::Migration[7.0]
  def change
    create_table :permissions do |t|
      t.references :project, null: false, foreign_key: true
      t.references :wallet, null: false, foreign_key: true
      t.string :kind

      t.timestamps
    end
  end
end
