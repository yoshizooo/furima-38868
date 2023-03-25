# テーブル設計

## usersテーブル
|Column            |Type    |Options                  |  
|------------------|--------|-------------------------|
|nickname          |string  |null: false              |
|email             |string  |null: false ,unique: true|
|encrypted_password|string  |null: false              |
|first_name        |string  |null: false              |
|last_name         |string  |null: false              |
|first_name_ kana  |string  |null: false              |
|last_name_kana    |string  |null: false              |
|birthday          |date    |null: false              |

### Association
- has_many :items
- has_many :purchase_histories

## itemsテーブル
|Column            |Type     |Options                         |  
|-------------------|---------|--------------------------------|
|product_name       |string   |null: false                     |
|category_id        |integer  |null: false                     |
|price              |integer  |null: false                     |
|product_description|string   |null: false                     |
|product_status_id  |integer  |null: false                     |
|shopping_fee_id    |integer  |null: false                     |
|schedule_date_id   |integer  |null: false                     |
|user               |reference|null: false ,foreign_key: true  |

### Association
- belongs_to :user
- has_one :purchase_history

#### カテゴリーデータ管理モデル
- product_statusモデル 商品状態管理
- shopping_feeモデル 送料
- schedule_dateモデル 発送するまでの日にち

## purchase_historiesテーブル
|Column            |Type     |Options                         |  
|------------------|---------|--------------------------------|
|user              |reference|null: false ,foreign_key: true  |
|item              |reference|null: false ,foreign_key: true  |

### Association
- belongs_to :item
- belongs_to :user
- has_one :shopping_address

## shopping_addressesテーブル
|Column            |Type     |Options                         |  
|------------------|---------|--------------------------------|
|post_code         |integer  |null: false                     |
|prefecture_id     |integer  |null: false                     |
|municipalities    |string   |null: false                     |
|address           |integer  |null: false                     |
|building_name     |text     |null: false                     |
|telephone_number  |integer  |null: false                     |
|purchase_history  |reference|null: false ,foreign_key: true  |

### Association
- belongs_to :purchase_history

#### カテゴリーデータ管理モデルの作成
- prefectureモデル 都道府県