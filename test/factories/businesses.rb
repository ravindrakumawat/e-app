FactoryBot.define do
  factory :business do
    name: { Faker::Name.first_name }
  end
end
