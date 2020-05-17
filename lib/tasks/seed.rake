require_relative "../../db/world_seed"

namespace :seed do
  namespace :csv do
    task all: [:customers, :mechants, :items, :invoices, :transactions]

    task customers: :environment do
      WorldSeed.load_csv('customers.csv', Customer)
    end

    task verify: :environment do
      Customer.all.each do |customer|
        puts customer.first_name
      end
    end
  end
end
