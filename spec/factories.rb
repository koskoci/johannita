FactoryBot.define do

  factory :user do
    password { "abc" }
    first_name { "Foo" }
    last_name { "Bar" }

    sequence(:email) { |n| "foo_#{n}@bar.com" }
  end

  factory :post do
    title { "My post" }
    content { "This is where I talk about everything that needs to be talked about." }
  end
end
