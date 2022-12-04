class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :email
      t.string :name
      t.integer :user_type
      t.string :password_digest

      t.timestamps
    end
  end
end
