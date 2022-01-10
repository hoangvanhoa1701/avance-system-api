class CreateLessons < ActiveRecord::Migration[6.1]
  def change
    create_table :lessons do |t|
      t.string :title
      t.string :link
      t.string :file
      t.timestamp :deleted_at
      t.references :session, null: true, foreign_key: true
      t.references :category, null: true, foreign_key: true
      t.references :unit, null: true, foreign_key: true

      t.timestamps
    end
  end
end
