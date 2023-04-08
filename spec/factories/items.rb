FactoryBot.define do
  factory :item do
    
    product_name              {Faker::Name.initials(number: 40)}
    category_id               {Faker::Number.between(from: 2, to: 10)}
    price                     {Faker::Number.between(from: 300, to: 9999999)}      
    product_description       {Faker::Lorem.characters(number: 1000)}
    product_status_id         {Faker::Number.between(from: 2, to: 7)}
    shopping_fee_id           {Faker::Number.between(from: 2, to: 2)}
    prefecture_id             {Faker::Number.between(from: 2, to: 48)}
    schedule_date_id          {Faker::Number.between(from: 2, to: 4)}
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/images (1).jpeg'), filename: 'images (1)')
    end
  end
end
