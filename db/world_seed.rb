require 'csv'

class WorldSeed
  def self.load_csv(filename, model_class)
    raise "Don't run this in production!" if Rails.env.production?

    model_class.delete_all
    models = []
    path = Rails.root.join('db', 'seeds', filename)
    CSV.foreach(path, headers: true) do |row|
      models << model_class.new(row.to_h)
    end
    model_class.import models, recursive: true
  end

  # def self.verify (model, filename)
  #
  # end

  private

  def self.open_csv(filename)
    csv_text = File.read(Rails.root.join('db', 'seeds', filename))
    CSV.parse(csv_text, headers: true, encoding: 'ISO-8859-1')
  end
end
