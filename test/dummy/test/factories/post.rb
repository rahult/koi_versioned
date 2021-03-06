FactoryGirl.define do
  factory :post do
    title        { Forgery(:lorem_ipsum).words(10) }
    body         { Forgery(:lorem_ipsum).paragraphs(10) }
    published_at { Forgery(:date).date }
    active       { Forgery(:basic).boolean }
  end
end

