namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_accounts
    make_users
    make_members
    make_catalog_items
  end
end

def make_accounts
  account = Account.create!(name:     "ABC Co",
                       subdomain:    "abc")
end

def make_users
  user = User.create!(name:     "Example User",
                       email:    "user@example.com",
                       password: "foobar")
  #admin.toggle!(:admin)
end

def make_members
  member = Account.first.memberize!(User.first)
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
end