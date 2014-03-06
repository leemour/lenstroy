FactoryGirl.define do
  factory :account, aliases: [:author, :user] do
    name             "John"
    surname          "Doe"
    sequence(:email) { |n| "person#{n}@example.com" }
    password         "password"
    password_confirmation "password"
    role             { Account.roles.keys.sample }
  end

  factory :page do
    account
    sequence(:slug) { |n| "path-to-page#{n}" }
    title           "Page title"
    content         "Lorem ipsum dolor sit amet"
    excerpt         "Lorem ipsum dolor sit amet"
    seo_title       "Lorem ipsum dolor sit amet"
    seo_desc        "Lorem ipsum dolor sit amet"
    seo_keys        "Lorem ipsum dolor sit amet"
    status          { Page.statuses.keys.sample }
  end
end