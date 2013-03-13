require 'csv'

namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    # make_accounts
    #     make_users
    #     make_sales_reps
    #     make_milestones
    # make_catalog_items
    #     make_contacts
    #     make_opportunities
  end
  
  
  desc "Import data from csv files"
  task import: :environment do
    import_accounts
    import_users
    import_sales_reps
    import_milestones
    import_oems
    import_oem_reps
    import_catalog_items
    import_companies
    import_contacts
    import_contact_phones
    import_contact_emails
    import_contact_addresses
    import_contact_urls
    # import_opportunities
    #  import_opportunity_contacts
    #  import_documents
    #  import_document_items
    #  import_templates
    #  import_template_items
  end
end

def import_accounts
  file = "db/import/accounts.csv"

  CSV.foreach(file, :headers => true) do |row|
    Account.create!(
      name: row[0],
      subdomain: row[1]
    )
  end
end

def import_users
  file = "db/import/users.csv"
  account = Account.new
  
  CSV.foreach(file, :headers => true) do |row|
    if Account.find(row[0]) != account.id
      account = Account.find(row[0])
    end
    
    if account.id?
      account.users.create!(
        name: row[1],
        email: row[2],
        password: row[3]
      )
    end
  end
end

def import_sales_reps
  file = "db/import/sales_reps.csv"
  account = Account.new
  
  CSV.foreach(file, :headers => true) do |row|
    if Account.find(row[0]) != account.id
      account = Account.find(row[0])
    end
    
    if account.id?
      if row[1] != ''
        user = User.find(row[1])
        if user?
          account.repize!(user)
        end
      else
        account.sales_reps.create!(
          name: row[2],
          email: row[3]
        )
      end
    end
  end
end

def import_milestones
  file = "db/import/milestones.csv"
  account = Account.new
  
  CSV.foreach(file, :headers => true) do |row|
    if Account.find(row[0]) != account.id
      account = Account.find(row[0])
    end
    
    if account.id?
      account.milestones.create!(
        name: row[1],
        probability: row[2]
      )
    end
  end
end


def import_oems
  file = "db/import/oems.csv"
  account = Account.new
  
  CSV.foreach(file, :headers => true) do |row|
    if Account.find(row[0]) != account.id
      account = Account.find(row[0])
    end
    
    if account.id?
      account.oems.create!(
        name: row[1]
      )
    end
  end
end


def import_oem_reps
  file = "db/import/oem_reps.csv"
  account = Account.new
  oem = Oem.new
  
  CSV.foreach(file, :headers => true) do |row|
    if Account.find(row[0]) != account.id
      account = Account.find(row[0])
    end
    
    if account.id?
      if row[1] != ''
        oem = Oem.find(row[1])
      end
      
      account.oem_reps.create!(
        oem_key: oem? ? oem.pub_key : null,
        name: row[2],
        phone: row[3],
        email: row[4]
      )
    end
  end
end


def import_catalog_items
  file = "db/import/catalog_items.csv"
  account = Account.new
  
  CSV.foreach(file, :headers => true) do |row|
    if Account.find(row[0]) != account.id
      account = Account.find(row[0])
    end
    
    if account.id?
      account.catalog_items.create!(
        name: row[1],
        part_number: row[2],
        manufacturer: row[3],
        description: row[4],
        list_price: row[5],
        list_price_unit: row[6],
        is_taxable: row[7],
        is_package: row[8]
      )
    end
  end
end


def import_companies
  file = "db/import/companies.csv"
  account = Account.new
  
  CSV.foreach(file, :headers => true) do |row|
    if Account.find(row[0]) != account.id
      account = Account.find(row[0])
    end
    
    if account.id?
      account.contacts.create!(
        name: row[1],
        is_company: true
      )
    end
  end
end


def import_contacts
  file = "db/import/contacts.csv"
  account = Account.new
  
  CSV.foreach(file, :headers => true) do |row|
    if Account.find(row[0]) != account.id
      account = Account.find(row[0])
    end
    
    if account.id?
      company = Contact.new
      
      if row[1] != ''
        company = Contact.find(row[1])
      end
      
      if company.id?
        account.contacts.create!(
          name: row[2],
          title: row[3],
          company_key: company.pub_key,
          is_company: false
        )
      else
        account.contacts.create!(
          name: row[2],
          title: row[3],
          is_company: false
        )
      end
    end
  end
end


def import_contact_phones
  file = "db/import/contact_phones.csv"
  account = Account.new
  
  CSV.foreach(file, :headers => true) do |row|
    if Account.find(row[0]) != account.id
      account = Account.find(row[0])
    end
    
    if account.id?
      contact = Contact.find(row[1])
      
      if contact.id?
        account.contact_phones.create!(
          name: row[2],
          val: row[3],
          contact_key: contact.pub_key
        )
      end
    end
  end
end


def import_contact_emails
  file = "db/import/contact_emails.csv"
  account = Account.new
  
  CSV.foreach(file, :headers => true) do |row|
    if Account.find(row[0]) != account.id
      account = Account.find(row[0])
    end
    
    if account.id?
      contact = Contact.find(row[1])
      
      if contact.id?
        account.contact_emails.create!(
          name: row[2],
          val: row[3],
          contact_key: contact.pub_key
        )
      end
    end
  end
end


def import_contact_urls
  file = "db/import/contact_urls.csv"
  account = Account.new
  
  CSV.foreach(file, :headers => true) do |row|
    if Account.find(row[0]) != account.id
      account = Account.find(row[0])
    end
    
    if account.id?
      contact = Contact.find(row[1])
      
      if contact.id?
        account.contact_urls.create!(
          name: row[2],
          val: row[3],
          contact_key: contact.pub_key
        )
      end
    end
  end
end


def import_contact_addresses
  file = "db/import/contact_addresses.csv"
  account = Account.new
  
  CSV.foreach(file, :headers => true) do |row|
    if Account.find(row[0]) != account.id
      account = Account.find(row[0])
    end
    
    if account.id?
      contact = Contact.find(row[1])
      
      if contact.id?
        account.contact_addresses.create!(
          name: row[2],
          street1: row[3],
          street2: row[4],
          city: row[5],
          state: row[6],
          zip: row[7],
          country: row[8],
          contact_key: contact.pub_key
        )
      end
    end
  end
end


def import_users
  file = "db/import/opportunities.csv"
  account = Account.new
  
  CSV.foreach(file, :headers => true) do |row|
    if Account.find(row[0]) != account.id
      account = Account.find(row[0])
    end
    
    if account.id?
      owner = SalesRep.find(row[1])
      company = Contact.find(row[2])
      oem = Oem.find(row[3])
      oem_rep = OemRep.find(row[4])
      milestone = Milestone.find(row[5])
      
      account.opportunities.create!(
        name: row[3],
        owner_key: owner? ? owner.pub_key : null,
        company_key: company? ? company.pub_key : null,
        oem_key: oem? ? oem.pub_key : null,
        oem_rep_key: oem_rep? ? oem_rep.pub_key : null,
        milestone_key: milesone? ? milestone.pub_key : null,
        
        # email: row[2],
        #         password: row[3]
      )
    end
  end
end




# def make_accounts
#   account = Account.create!(name:     "Sitech-SE",
#                        subdomain:    "sitechse")
#                        
#   # account = Account.create!(name:     "Company 2",
#   #                         subdomain:    "co2")
# end
# 
# def make_users
#   user1 = Account.first.users.create!(name:     "Jeremy Pastika",
#                        email:    "jpastika@sitech-se.com",
#                        password: "foobar")
#   user2 = Account.first.users.create!(name:     "Greg Hasty",
#                       email:    "ghasty@sitech-se.com",
#                       password: "foobar")
#   user3 = Account.first.users.create!(name:     "Mike Nixon",
#                       email:    "mnixon@sitech-se.com",
#                       password: "foobar")
#   user4 = Account.first.users.create!(name:     "Rob Curry",
#                       email:    "rcurry@sitech-se.com",
#                       password: "foobar")
#   user5 = Account.first.users.create!(name:     "Richard Stagg",
#                       email:    "rstagg@sitech-se.com",
#                       password: "foobar")
#   user6 = Account.first.users.create!(name:     "Jim Hiler",
#                       email:    "jhiler@sitech-se.com",
#                       password: "foobar")
#   #admin.toggle!(:admin)
# end
# 
# def make_sales_reps
#   rep = Account.first.repize!(Account.first.users[0])
#   rep = Account.first.repize!(Account.first.users[1])
#   rep = Account.first.repize!(Account.first.users[2])
#   rep = Account.first.repize!(Account.first.users[3])
#   rep = Account.first.repize!(Account.first.users[4])
#   rep = Account.first.repize!(Account.first.users[5])
# end
# 
# def make_catalog_items
#   item_seq = 0
#   price = 50
#   3.times do
#     item_seq += 1
#     price += price
#     name = "Item #{item_seq}"
#     
#     Account.first.catalog_items.create!(name: name, list_price: price)
#   end
#   
#   price = 25
#   3.times do
#     item_seq += 1
#     price += price
#     name = "Item #{item_seq}"
#     
#     Account.first.catalog_items.create!(name: name, list_price: price)
#   end
#   
#   price = 10
#   3.times do
#     item_seq += 1
#     price += price
#     name = "Item #{item_seq}"
#     
#     Account.first.catalog_items.create!(name: name, list_price: price, is_recurring: true, recurring_unit: "month")
#   end
#   
#   price = 15
#   3.times do
#     item_seq += 1
#     price += price
#     name = "Item #{item_seq}"
#     
#     Account.first.catalog_items.create!(name: name, list_price: price, is_subscription: true, subscription_length: 1, subscription_length_unit: "year")
#   end
#   
#   price = 15
#   3.times do
#     item_seq += 1
#     price += price
#     name = "Item #{item_seq}"
#     
#     Account.last.catalog_items.create!(name: name, list_price: price, is_subscription: true, subscription_length: 1, subscription_length_unit: "year")
#   end
# end
# 
# 
# def make_contacts
#   item_seq = 0
#   
#   item_seq += 1
#   name = "ABC Company"
#   contact_type_key = Account.first.contact_types.find_by_name("Company").pub_key
#   
#   Account.first.contacts.create!(name: name, contact_type_key: contact_type_key)
#   
#   
#   item_seq += 1
#   name = "Bob Dole"
#   contact_type_key = Account.first.contact_types.find_by_name("Person").pub_key
#   company_key = Account.first.contacts.companies(Account.first).first.pub_key
#   
#   Account.first.contacts.create!(name: name, contact_type_key: contact_type_key, company_key: company_key)
# end
# 
# 
# def make_opportunities
#   # item_seq = 0
#   #   
#   #   item_seq += 1
#   #   name = "Opportunity #{item_seq}"
#   #   owner_key = User.first.pub_key
#   #   creator_key = User.first.pub_key
#   #   milestone_key = Account.first.milestones.first.pub_key
#   #   estimated_close = Timeliness.parse("8/20/2012", :format => "m/d/yyyy")
#   #   estimated_value = "52000"
#   #   company_key = Account.first.contacts.companies(Account.first).first.pub_key
#   #   
#   #   Account.first.opportunities.create!(name: name, owner_key: owner_key, creator_key: creator_key, milestone_key: milestone_key, estimated_close: estimated_close, estimated_value: estimated_value, company_key: company_key)
#   #   
#   #   
#   #   item_seq += 1
#   #   name = "Opportunity #{item_seq}"
#   #   owner_key = User.first.pub_key
#   #   creator_key = User.first.pub_key
#   #   milestone_key = Account.first.milestones.first.pub_key
#   #   estimated_close = Timeliness.parse("9/7/2012", :format => "m/d/yyyy")
#   #   estimated_value = "67000"
#   #   company_key = Account.first.contacts.companies(Account.first).first.pub_key
#   #   
#   #   Account.first.opportunities.create!(name: name, owner_key: owner_key, creator_key: creator_key, milestone_key: milestone_key, estimated_close: estimated_close, estimated_value: estimated_value, company_key: company_key)
#   #   
#   #   
#   #   item_seq += 1
#   #   name = "Opportunity #{item_seq}"
#   #   owner_key = User.first.pub_key
#   #   creator_key = User.first.pub_key
#   #   milestone_key = Account.first.milestones.last.pub_key
#   #   estimated_close = Timeliness.parse("7/26/2012", :format => "m/d/yyyy")
#   #   estimated_value = "12000"
#   #   company_key = Account.first.contacts.companies(Account.first).first.pub_key
#   #   
#   #   Account.first.opportunities.create!(name: name, owner_key: owner_key, creator_key: creator_key, milestone_key: milestone_key, estimated_close: estimated_close, estimated_value: estimated_value, company_key: company_key)
#   #   
#   #   
#   #   item_seq += 1
#   #   name = "Opportunity #{item_seq}"
#   #   owner_key = User.first.pub_key
#   #   creator_key = User.first.pub_key
#   #   milestone_key = Account.first.milestones.last.pub_key
#   #   estimated_close = Timeliness.parse("7/30/2012", :format => "m/d/yyyy")
#   #   estimated_value = "110000"
#   #   company_key = Account.first.contacts.companies(Account.first).first.pub_key
#   #   
#   #   Account.first.opportunities.create!(name: name, owner_key: owner_key, creator_key: creator_key, milestone_key: milestone_key, estimated_close: estimated_close, estimated_value: estimated_value, company_key: company_key)
#   #   
#   #   
#   #   item_seq = 0
#   #   name = "Opportunity #{item_seq}"
#   #   owner_key = User.last.pub_key
#   #   creator_key = User.last.pub_key
#   #   milestone_key = Account.last.milestones.first.pub_key
#   #   estimated_close = Timeliness.parse("10/10/2012", :format => "m/d/yyyy")
#   #   estimated_value = "54000"
#   #   company_key = Account.first.contacts.companies(Account.first).first.pub_key
#   #   
#   #   Account.last.opportunities.create!(name: name, owner_key: owner_key, creator_key: creator_key, milestone_key: milestone_key, estimated_close: estimated_close, estimated_value: estimated_value, company_key: company_key)
#   #  
# end