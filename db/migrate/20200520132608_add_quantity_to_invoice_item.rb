class AddQuantityToInvoiceItem < ActiveRecord::Migration[5.2]
  def change
    add_column :invoice_items, :quantity, :integer
    add_column :invoice_items, :unit_price, :decimal
  end
end
