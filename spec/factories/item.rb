FactoryBot.define do
  factory :item do
    name { Faker::Food.ingredient }
    amount { Faker::Number.between(from: 1, to: 10) }
    section { Faker::Commerce.department(max: 1) }
  end
end
