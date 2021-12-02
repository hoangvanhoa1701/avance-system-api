class CreateProgramsUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :programs_users do |t|
      t.belongs_to :program
      t.belongs_to :user
      
      t.timestamps
    end
  end
end
