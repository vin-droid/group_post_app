class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :full_name
      t.string :email
      t.integer :age
      t.string :sex
      t.string :password_digest

      t.timestamps
    end
  end
end
