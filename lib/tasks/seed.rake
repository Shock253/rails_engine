require_relative "../../db/world_seed"

namespace :seed do
  namespace :csv do
    task all: [:reset_db, :customers, :merchants, :items, :invoices, :transactions]

    task reset_db: :environment do
      raise "Don't run this in production!" if Rails.env.production?
      ActiveRecord::Tasks::DatabaseTasks.env = 'test'
      Rake::Task["db:drop"].execute
      Rake::Task["db:create"].execute
      Rake::Task["db:migrate"].execute

      ActiveRecord::Tasks::DatabaseTasks.env = 'development'
      Rake::Task["db:drop"].execute
      Rake::Task["db:create"].execute
      Rake::Task["db:migrate"].execute

      # the order here is important, we want to make sure that we catch all
      # the tables in this order, otherwise attempting to delete tables that
      # still have references elsewhere will throw an error. If we want to seed
      # a table individually, we just have to remember that's a concern.
      InvoiceItem.delete_all if InvoiceItem.table_exists?
      Transaction.delete_all if Transaction.table_exists?
      Invoice.delete_all if Invoice.table_exists?
      Item.delete_all if Item.table_exists?
      Merchant.delete_all if Merchant.table_exists?
      Customer.delete_all if Customer.table_exists?
    end

    task customers: :environment do
      puts "Loading Customers..."
      WorldSeed.load_csv('customers.csv', Customer)
    end

    task merchants: :environment do
      puts "Loading Merchants..."
      WorldSeed.load_csv('merchants.csv', Merchant)
    end

    task items: :environment do
      puts "Loading Items..."
      WorldSeed.load_csv('items.csv', Item) do |row|
        row["unit_price"] = row["unit_price"].to_f / 100.0
        Item.new(row.to_h)
      end
    end

    task invoices: :environment do
      puts "Loading Invoices..."
      WorldSeed.load_csv('invoices.csv', Invoice)
      puts "Loading Invoice Items..."
      WorldSeed.load_csv('invoice_items.csv', InvoiceItem) do |row|
        row["unit_price"] = row["unit_price"].to_f / 100.0
        InvoiceItem.new(row.to_h)
      end
    end

    task transactions: :environment do
      puts "Loading Transactions..."
      WorldSeed.load_csv('transactions.csv', Transaction)
    end
  end
end
