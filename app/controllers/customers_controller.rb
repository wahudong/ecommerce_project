# frozen_string_literal: true

class CustomersController < ApplicationController
  def edit
    # @customers = Customer.where('user = ?', current_user)
    @customers = Customer.where('user_id = ?', current_user.id) # where always returns a collection.
    # @customer = current_user.id
  end
end
