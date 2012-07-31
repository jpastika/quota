namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_accounts
    make_users
    make_catalog_items
    make_contacts
    make_opportunities
  end
end

def make_accounts
  account = Account.create!(name:     "Company 1",
                       subdomain:    "co1")
                       
  account = Account.create!(name:     "Company 2",
                        subdomain:    "co2")
end

def make_users
  user = Account.first.users.create!(name:     "User One",
                       email:    "user1@example.com",
                       password: "foobar")
  user = Account.first.users.create!(name:     "User Two",
                      email:    "user2@example.com",
                       password: "foobar")
  #admin.toggle!(:admin)
end

def make_catalog_items
  item_seq = 0
  price = 50
  3.times do
    item_seq += 1
    price += price
    name = "Item #{item_seq}"
    
    Account.first.catalog_items.create!(name: name, list_price: price)
  end
  
  price = 25
  3.times do
    item_seq += 1
    price += price
    name = "Item #{item_seq}"
    
    Account.first.catalog_items.create!(name: name, list_price: price)
  end
  
  price = 10
  3.times do
    item_seq += 1
    price += price
    name = "Item #{item_seq}"
    
    Account.first.catalog_items.create!(name: name, list_price: price, is_recurring: true, recurring_unit: "month")
  end
  
  price = 15
  3.times do
    item_seq += 1
    price += price
    name = "Item #{item_seq}"
    
    Account.first.catalog_items.create!(name: name, list_price: price, is_subscription: true, subscription_length: 1, subscription_length_unit: "year")
  end
  
  price = 15
  3.times do
    item_seq += 1
    price += price
    name = "Item #{item_seq}"
    
    Account.last.catalog_items.create!(name: name, list_price: price, is_subscription: true, subscription_length: 1, subscription_length_unit: "year")
  end
end


def make_contacts
  item_seq = 0
  
  item_seq += 1
  name = "ABC Company"
  contact_type_key = Account.first.contact_types.find_by_name("Company").pub_key
  
  Account.first.contacts.create!(name: name, contact_type_key: contact_type_key)
  
  
  item_seq += 1
  name = "Bob Dole"
  contact_type_key = Account.first.contact_types.find_by_name("Person").pub_key
  company_key = Account.first.contacts.companies(Account.first).first.pub_key
  
  Account.first.contacts.create!(name: name, contact_type_key: contact_type_key, company_key: company_key)
end


def make_opportunities
  item_seq = 0
  
  item_seq += 1
  name = "Opportunity #{item_seq}"
  owner_key = User.first.pub_key
  creator_key = User.first.pub_key
  milestone_key = Account.first.milestones.first.pub_key
  estimated_close = Timeliness.parse("8/20/2012", :format => "m/d/yyyy")
  estimated_value = "52000"
  company_key = Account.first.contacts.companies(Account.first).first.pub_key
  
  Account.first.opportunities.create!(name: name, owner_key: owner_key, creator_key: creator_key, milestone_key: milestone_key, estimated_close: estimated_close, estimated_value: estimated_value, company_key: company_key)
  
  
  item_seq += 1
  name = "Opportunity #{item_seq}"
  owner_key = User.first.pub_key
  creator_key = User.first.pub_key
  milestone_key = Account.first.milestones.first.pub_key
  estimated_close = Timeliness.parse("9/7/2012", :format => "m/d/yyyy")
  estimated_value = "67000"
  company_key = Account.first.contacts.companies(Account.first).first.pub_key
  
  Account.first.opportunities.create!(name: name, owner_key: owner_key, creator_key: creator_key, milestone_key: milestone_key, estimated_close: estimated_close, estimated_value: estimated_value, company_key: company_key)
  
  
  item_seq += 1
  name = "Opportunity #{item_seq}"
  owner_key = User.first.pub_key
  creator_key = User.first.pub_key
  milestone_key = Account.first.milestones.last.pub_key
  estimated_close = Timeliness.parse("7/26/2012", :format => "m/d/yyyy")
  estimated_value = "12000"
  company_key = Account.first.contacts.companies(Account.first).first.pub_key
  
  Account.first.opportunities.create!(name: name, owner_key: owner_key, creator_key: creator_key, milestone_key: milestone_key, estimated_close: estimated_close, estimated_value: estimated_value, company_key: company_key)
  
  
  item_seq += 1
  name = "Opportunity #{item_seq}"
  owner_key = User.first.pub_key
  creator_key = User.first.pub_key
  milestone_key = Account.first.milestones.last.pub_key
  estimated_close = Timeliness.parse("7/30/2012", :format => "m/d/yyyy")
  estimated_value = "110000"
  company_key = Account.first.contacts.companies(Account.first).first.pub_key
  
  Account.first.opportunities.create!(name: name, owner_key: owner_key, creator_key: creator_key, milestone_key: milestone_key, estimated_close: estimated_close, estimated_value: estimated_value, company_key: company_key)
  
  
  item_seq = 0
  name = "Opportunity #{item_seq}"
  owner_key = User.last.pub_key
  creator_key = User.last.pub_key
  milestone_key = Account.last.milestones.first.pub_key
  estimated_close = Timeliness.parse("10/10/2012", :format => "m/d/yyyy")
  estimated_value = "54000"
  company_key = Account.first.contacts.companies(Account.first).first.pub_key
  
  Account.last.opportunities.create!(name: name, owner_key: owner_key, creator_key: creator_key, milestone_key: milestone_key, estimated_close: estimated_close, estimated_value: estimated_value, company_key: company_key)
 
end