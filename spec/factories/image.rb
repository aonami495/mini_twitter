FactoryBot.define do
  factory :image do
    image_url { "https://" }
    association :post
  end
end
