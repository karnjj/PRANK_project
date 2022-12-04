class CreateMarkets < ActiveRecord::Migration[7.0]
  def change
    create_table :markets do |t|
      t.references :item, null: false, foreign_key: true
      t.integer :price
      t.integer :stock
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
