FactoryBot.define do
  factory :item do
    name { Faker::Name.unique.name }
    description { Faker::Movies::HitchhikersGuideToTheGalaxy.marvin_quote }
    unit_price { Faker::Number.number(digits: 3) }
  end
end
