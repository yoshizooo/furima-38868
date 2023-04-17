FactoryBot.define do
  factory :purchase_history_shopping_address do
    post_code                 { '330-0063'}
    prefecture_id             { Faker::Number.between(from: 2, to: 48) }
    municipalities            { Gimei.address.city.kanji}
    address                   { Faker::Number.between(from: 2, to: 4) }
    building_name             { 'test' }
    telephone_number          { Faker::PhoneNumber.subscriber_number(length: 10)}
    token                     {'tok_abcdefghijk00000000000000000'}
  
  end
end
