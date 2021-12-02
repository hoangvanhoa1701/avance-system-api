class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.string :fullname
      t.string :phone
      t.string :avatar
      t.string :language
      t.string :status
      t.integer :role

      t.timestamps
    end
  end
end
