class CreateResources < ActiveRecord::Migration[6.1]
  def change
    create_table :resources do |t|
      t.string :link
      t.string :file
      t.timestamp :deleted_at
      t.references :lesson, null: false, foreign_key: true

      t.timestamps
    end
  end
end
