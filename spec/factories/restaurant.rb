FactoryBot.define do
  factory :restaurant do
    name { Faker::Restaurant.name }
    customer_rating { rand(1..5) }
    distance { rand(1..10) }
    price { rand(10..50) }
    cuisine { create(:cuisine) }
  end

  trait :with_chow_in_the_name do
    name { Faker::Restaurant.name+"Chow" }
  end
end
