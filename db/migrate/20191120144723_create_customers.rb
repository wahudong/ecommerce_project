class CreateCustomers < ActiveRecord::Migration[6.0]
  def change
    create_table :customers do |t|
      t.string :name
      t.string :login_name
      t.string :password
      t.string :street_no
      t.string :street_name
      t.string :city
      t.string :province
      t.string :postal_code
      t.string :email
      t.string :phone

      t.timestamps
    end
  end
end
