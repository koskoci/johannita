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

  factory :event do
    title { "My event"}
    category { "Elsosegely-tanfolyam"}
    date { "2019/1/1" }
    status { "posted" }
    apply_by { "2018/11/1" }
  end
end
