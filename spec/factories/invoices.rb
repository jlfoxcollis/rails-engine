FactoryBot.define do
  factory :invoice do
    status { Faker::Number.between(from: 0, to: 3) }
  end
end
