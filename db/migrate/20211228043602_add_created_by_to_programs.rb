class AddCreatedByToPrograms < ActiveRecord::Migration[6.1]
  def change
    add_column :programs, :created_by, :integer
  end
end
