# frozen_string_literal: true

class AddUserRefToCustomers < ActiveRecord::Migration[6.0]
  def change
    add_reference :customers, :user, foreign_key: true
  end
end
