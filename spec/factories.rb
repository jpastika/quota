FactoryGirl.define do
  
  factory :account do
    sequence(:name)  { |n| "Company #{n}" }
    sequence(:subdomain) { |n| "co#{n}" }
  end
  
  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com" }
    password "foobar"
    password_confirmation "foobar"
    
    #factory :admin do
    #  admin true
    #end
  end
  
end