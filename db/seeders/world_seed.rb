require 'csv'

class WorldSeed
  def self.load_csv(filename, &block)
    raise "Don't run this in production!" if Rails.env.production?
    csv_text = File.read(Rails.root.join('db', 'seeds', filename))
    csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
    csv.each do |row|
      model = block.call(row)
      if !model.save
        raise "There's something wrong with the model data..."
      end
    end
  end
end
