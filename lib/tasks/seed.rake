require_relative "../../db/world_seed"

namespace :seed do
  namespace :csv do
    task all: [:customers, :merchants, :items, :invoices, :transactions]

    task customers: :environment do
      WorldSeed.load_csv('customers.csv', Customer)
    end

    task merchants: :environment do
      WorldSeed.load_csv('merchants.csv', Merchant)
    end

    task items: :environment do
      WorldSeed.load_csv('items.csv', Item)
    end

    task invoices: :environment do
      WorldSeed.load_csv('invoices.csv', Invoice)
      WorldSeed.load_csv('invoice_items.csv', InvoiceItem)
    end

    task transactions: :environment do
      WorldSeed.load_csv('transactions.csv', Transaction)
    end

    task verify: :environment do

    end
  end
end
