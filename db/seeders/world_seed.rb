require 'csv'
require '../../app/models/customer'

class WorldSeed
  def self.from_csv
    raise "Don't run this in production!" if Rails.env.production?

    Customer.delete_all
    load_csv('customers.csv') do |row|
      binding.pry
      t = Customer.new
      t.name
    end
  end

  def self.load_csv(filename, &block)
    csv_text = File.read(Rails.root.join('lib', 'seeds', filename))
    csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
    csv.each do |row|
      model = block.call(row)
      model.save
    end
  end
end
