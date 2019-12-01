# frozen_string_literal: true

class OrdersController < ApplicationController
  def create
    products = Product.find(session[:cart]) # find的参数如果是一个，就返回一个值。如果find的参数是一组，那么也返回一个数组

    amount = 0
    products.each do |p|
      amount += p.price
    end
    # @product = params[:product_arr]

    customer = Customer.find_by_user_id(current_user.id)

    province = Customer.find_by_user_id(current_user.id).province
    tax_province = Tax.find_by_province(province)

    @order = customer.orders.create(street_no: customer.street_no, street_name: customer.street_name, city: customer.city, province: customer.province, postal_cade: customer.postal_code, status: 'Paid', gst: tax_province.gst, pst: tax_province.pst, total_amount: amount * (1 + tax_province.pst + tax_province.gst))

    products.each do |p|
      sold_product = SoldProduct.create(order: @order, product: p, unit_price: p.price, quantity: 1)
    end

    session[:cart] = []
    load_cart
  end
end
