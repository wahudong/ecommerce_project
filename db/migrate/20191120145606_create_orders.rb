class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.references :customer, null: false, foreign_key: true
      t.string :street_no
      t.string :street_name
      t.string :city
      t.string :province
      t.string :postal_cade
      t.string :status
      t.decimal :pst
      t.decimal :gst
      t.decimal :total_amount

      t.timestamps
    end
  end
end
