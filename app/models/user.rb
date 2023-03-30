class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]{6,}+\z/i.freeze
         VALID_FistName_REGEX = /\A(?:\p{Hiragana}|\p{Katakana}|[ー－]|[一-龠々])+\z/i.freeze
         VALID_LastName_REGEX = /\A(?:\p{Hiragana}|\p{Katakana}|[ー－]|[一-龠々])+\z/i.freeze
         VALID_FistNameKana_REGEX = /\A[ァ-ヶー－]+\z/i.freeze
         VALID_LastNameKana_REGEX = /\A[ァ-ヶー－]+\z/i.freeze
         validates :password, format: { with: VALID_PASSWORD_REGEX, message: ' is invalid. Include both letters and numbers', allow_blank: true}
         validates :nickname, presence: true
         validates :last_name, presence: true, format: { with:VALID_LastName_REGEX, message: 'is invalid. Input full-width characters', allow_blank: true}
         validates :first_name, presence: true, format: { with:VALID_FistName_REGEX, message: 'is invalid. Input full-width characters', allow_blank: true}
         validates :last_name_kana, presence: true, format: { with:VALID_LastNameKana_REGEX, message: 'is invalid. Input full-width katakana characters', allow_blank: true}
         validates :first_name_kana, presence: true, format: { with:VALID_FistNameKana_REGEX, message: 'is invalid. Input full-width katakana characters', allow_blank: true}
         validates :birthday, presence: true

         
end
