class PurchaseHistoryShoppingAddress
  include ActiveModel::Model
  attr_accessor :post_code, :prefecture_id, :municipalities, :address, :building_name, :telephone_number, :user_id, :item_id

  VALID_PostCode_REGEX = /\A\d{3}-\d{4}\z/i.freeze
  VALID_TelephoneNumber_REGEX = /\A\d{10,11}\z/i.freeze

  with_options presence: true do
    validates :post_code,
              format: { with: VALID_PostCode_REGEX, message: 'is invalid. Enter it as follows (e.g. 123-4567)',
                        allow_blank: true }
    validates :municipalities
    validates :prefecture_id
    validates :address
    validates :telephone_number
    validates :user_id
    validates :item_id
    validates :token
  end
  validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :telephone_number, format: { with: VALID_TelephoneNumber_REGEX, message: 'Phone number is invalid. Input only number', allow_blank: true }
  validates :telephone_number, length: { minimum: 10, maximum: 11, allow_blank: true}
  

  def save
    purchase_history = PurchaseHistory.create(user_id: user_id, item_id: item_id)
    ShoppingAddress.create(post_code: post_code, municipalities: municipalities, prefecture_id: prefecture_id, address: address,
                           building_name: building_name, telephone_number: telephone_number, purchase_history_id: purchase_history.id)
  end

  attr_accessor :token

end
