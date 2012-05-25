namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_accounts
    make_users
    make_members
    make_catalog_items
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
  user = User.create!(name:     "User One",
                       email:    "user1@example.com",
                       password: "foobar")
  user = User.create!(name:     "User Two",
                      email:    "user2@example.com",
                       password: "foobar")
  #admin.toggle!(:admin)
end

def make_members
  member = Account.first.memberize!(User.first)
  member = Account.last.memberize!(User.last)
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

def make_opportunities
  item_seq = 0
  3.times do
    item_seq += 1
    name = "Opportunity #{item_seq}"
    owner_key = Member.first.pub_key
    creator_key = Member.first.pub_key
    
    Account.first.opportunities.create!(name: name, owner_key: owner_key, creator_key: creator_key)
  end
  
  item_seq = 0
  1.times do
    item_seq += 1
    name = "Opportunity #{item_seq}"
    owner_key = Member.first.pub_key
    creator_key = Member.last.pub_key
    
    Account.last.opportunities.create!(name: name, owner_key: owner_key, creator_key: creator_key)
  end
end