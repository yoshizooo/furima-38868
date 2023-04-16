class CreateShoppingAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :shopping_addresses do |t|
      t.string :post_code,            null: false
      t.integer :prefecture_id,       null: false
      t.string :municipalities,       null: false
      t.string :address,              null: false
      t.string :building_name,        null: false
      t.string :telephone_number,     null: false
      t.references :purchase_history, null: false ,foreign_key: true
      t.timestamps
    end
  end
end
