require 'csv'

class WorldSeed
  def self.load_csv(filename, model_class, &block)
    raise "Don't run this in production!" if Rails.env.production?

    model_class.delete_all if model_class.table_exists?
    models = []
    path = Rails.root.join('db', 'seeds', filename)
    if block.nil?
      CSV.foreach(path, headers: true) do |row|
        models << model_class.new(row.to_h)
      end
    else
      CSV.foreach(path, headers: true) do |row|
        models << block.call(row)
      end
    end
    model_class.import models, recursive: true
  end

  private

  def self.open_csv(filename)
    csv_text = File.read(Rails.root.join('db', 'seeds', filename))
    CSV.parse(csv_text, headers: true, encoding: 'ISO-8859-1')
  end
end
