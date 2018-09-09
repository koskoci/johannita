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
    date { "2019/1/1" }
    status { "posted" }
    apply_by { "2018/11/1" }
    association :course_category, factory: :course_category
  end

  factory :course_category do
    last_date { "2018-01-01" }
    category { "Elsosegely-tanfolyam"}
  end
end
