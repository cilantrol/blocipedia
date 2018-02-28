FactoryBot.define do
  factory :wiki do
    title Faker::Lorem.sentence(2)
    body Faker::Lorem.paragraph
    private false
    user nil
  end
end
