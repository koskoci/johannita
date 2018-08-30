FactoryBot.define do

  factory :user do
    email { "foo@bar.com" }
    password { "abc" }
    first_name { "Foo" }
    last_name { "Bar" }
  end

  factory :post do
    title { "My post" }
    content { "This is where I talk about everything that needs to be talked about." }
  end
end
