class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :prefecture
  belongs_to :product_status
  belongs_to :shopping_fee
  belongs_to :schedule_date
  belongs_to :user
  has_one_attached :image

  validates :image, presence: true
  validates :product_name, presence: true, length: { maximum: 40, allow_blank: true }
  validates :category_id, numericality: { other_than: 1, message: "can't be blank", allow_blank: true }
  validates_inclusion_of :price, { in: 300..9_999_999, message: 'is out of setting range', allow_blank: true }
  validates :price, numericality: { only_integer: true, message: 'is invalid. Input half-width characters', allow_blank: true }
  validates :price, presence: true
  validates :product_description, presence: true, length: { maximum: 1_000, allow_blank: true }
  validates :product_status_id, presence: true, numericality: { other_than: 1, message: "can't be blank", allow_blank: true }
  validates :shopping_fee_id, presence: true, numericality: { other_than: 1, message: "can't be blank", allow_blank: true }
  validates :prefecture_id, presence: true, numericality: { other_than: 1, message: "can't be blank", allow_blank: true }
  validates :schedule_date_id, presence: true, numericality: { other_than: 1, message: "can't be blank", allow_blank: true }
end
