class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string :product_name,      null: false
      t.integer :category_id,      null: false
      t.integer :price,            null: false
      t.text :product_description, null: false
      t.integer :product_status_id,null: false
      t.integer :shopping_fee_id,  null: false
      t.integer :prefecture_id,    null: false
      t.integer :schedule_date_id, null: false
      t.references :user,          null: false ,foreign_key: true
      t.timestamps
    end
  end
end
