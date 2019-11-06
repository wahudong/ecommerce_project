class RemoveProductNameFromProducts < ActiveRecord::Migration[6.0]
  def change

    remove_column :products, :product_name, :string
  end
end
