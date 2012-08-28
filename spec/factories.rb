FactoryGirl.define do
  
  sequence :subdomain do |n|
    "co#{n}"
  end
  
  factory :account do
    sequence(:name)  { |n| "Company #{n}" }
    subdomain { FactoryGirl.generate(:subdomain) }
  end
  
  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com" }
    password "foobar"
    password_confirmation "foobar"
    account
    
    #factory :admin do
    #  admin true
    #end
  end
  
  # factory :member do
  #     account
  #     user
  #   end
  
  
  factory :catalog_item do
    sequence(:name)  { |n| "Item #{n}" }
    list_price 100
    account
  end
  
  factory :opportunity do
    sequence(:name)  { |n| "Opportunity #{n}" }
    creator_key { FactoryGirl.create(:user).pub_key }
    owner_key { FactoryGirl.create(:user).pub_key }
    account
  end
  
  factory :document do
    sequence(:name)  { |n| "Document #{n}" }
    creator_key { FactoryGirl.create(:user).pub_key }
    opportunity
    account
  end
  
  factory :document_type do
    sequence(:name)  { |n| "Quote" }
    # created_by { FactoryGirl.create(:user) }
    account
  end
  
  # factory :quote do
  #     sequence(:name)  { |n| "Quote #{n}" }
  #     created_by { FactoryGirl.create(:member) }
  #     opportunity
  #     account
  #   end
  
  factory :sales_rep do
    sequence(:name)  { |n| "Rep #{n}" }
    user
    account
  end
  
  factory :contact do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:title) { |n| "Title #{n}" }
    account
    
    factory :person do
      contact_type_key { FactoryGirl.create(:contact_type_person).pub_key }
    end
    
    factory :company do
      contact_type_key { FactoryGirl.create(:contact_type_company).pub_key }
    end
  end
  
  factory :contact_type do
    account
    factory :contact_type_person do
      name "Person"
    end
    
    factory :contact_type_company do
      name "Company"
    end
  end
  
end