class CreateSessions < ActiveRecord::Migration[6.1]
  def change
    create_table :sessions do |t|
      t.string :title
      t.timestamp :deleted_at
      t.references :program, null: false, foreign_key: true

      t.timestamps
    end
  end
end
