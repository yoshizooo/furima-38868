# テーブル設計

## usersテーブル
|Column            |Type    |Options     |  
|------------------|--------|------------|
|nickname          |string  |null: false |
|email             |string  |null: false |
|encrypted_password|string  |null: false |
|FirstName         |string  |null: false |
|LastName          |string  |null: false |
|birthday          |integer |null: false |

### アイソレーション
- has_many :items
- has_many :purchaseHistories

## itemsテーブル
|Column            |Type     |Options                         |  
|------------------|---------|--------------------------------|
|image             |string   |null: false                     |
|productName       |string   |null: false                     |
|Category          |string   |null: false                     |
|price             |integer  |null: false                     |
|ProductDescription|string   |null: false                     |
|ProductStatus     |string   |null: false                     |
|ShoppingFee       |string   |null: false                     |
|ScheduleDate      |string   |null: false                     |
|user_id           |reference|null: false ,foreign_kye: true  |

### アイソレーション
- belongs_to :user
- has_one :purchaseHistories

## purchaseHistoriesテーブル
|Column            |Type     |Options                         |  
|------------------|---------|--------------------------------|
|user_id           |reference|null: false ,foreign_kye: true  |
|item_id           |reference|null: false ,foreign_kye: true  |

### アイソレーション
- belongs_to :item
- belongs_to :user
- has_one :ShoppingAddress

## ShoppingAddressテーブル
|Column            |Type     |Options                         |  
|------------------|---------|--------------------------------|
|PostCode          |integer  |null: false                     |
|prefecture        |string   |null: false                     |
|Municipalities    |string   |null: false                     |
|address           |integer  |null: false                     |
|BuildingName      |text     |null: false                     |
|TelephoneNumber   |integer  |null: false                     |

### アイソレーション
- belongs_to :purchaseHistories