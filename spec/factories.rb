FactoryBot.define do

  factory :user do
    password { "abc" }
    first_name { "Foo" }
    last_name { "Bar" }
    email_confirmed { true }

    sequence(:email) { |n| "foo_#{n}@bar.com" }
  end

  factory :post do
    title { "My post" }
    content { "This is where I talk about everything that needs to be talked about." }
  end

  factory :course_event do
    title { "My course_event" }
    date { Date.today + 14 }
    association :course, factory: :course
  end

  factory :course_category do
    category { "kismama"}
    title { "First aid course for new parents" }
  end

  factory :participant do
    attended { nil }
    passed { nil }
    association :course, factory: :course
    association :user, factory: :user
  end

  factory :course do
    title { nil }
    apply_by { Date.today + 7 }
    status { "posted" }
    association :course_category, factory: :course_category
  end
end
