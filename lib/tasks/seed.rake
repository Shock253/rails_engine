require "seeders/customer_seed.rb"
require "seeders/invoice_item_seed.rb"
require "seeders/invoice_seed.rb"
require "seeders/item_seed.rb"
require "seeders/merchant_seed.rb"
require "seeders/transaction_seed.rb"

namespace :seed do
  namespace :csv do
    task customers: :environment do
      csv = File.read(Rails.root.join('lib', 'seeds', 'merchants.csv'))
      CustomerSeed.from_csv(csv)
    end

    rake_task = task invoice_items: :environment do
      csv = File.read(Rails.root.join('lib', 'seeds', 'items.csv'))
      InvoiceItemSeed.from_csv(csv)
    end

    task invoices: :environment do
      csv = File.read(Rails.root.join('lib', 'seeds', 'items.csv'))
      InvoiceSeed.from_csv(csv)
    end

    task items: :environment do
      csv = File.read(Rails.root.join('lib', 'seeds', 'merchants.csv'))
      ItemSeed.from_csv(csv)
    end

    task merchants: :environment do
      csv = File.read(Rails.root.join('lib', 'seeds', 'merchants.csv'))
      MerchantSeed.from_csv(csv)
    end

    task transactions: :environment do
      csv = File.read(Rails.root.join('lib', 'seeds', 'merchants.csv'))
      MerchantSeed.from_csv(csv)
    end
  end
end
