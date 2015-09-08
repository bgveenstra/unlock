class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :info
      t.string :email
      t.string :password_digest
      t.string :image

      t.timestamps null: false
    end
  end
end
