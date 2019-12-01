# frozen_string_literal: true

class CheckoutController < ApplicationController
  before_action :authenticate_user!

  $product_arr = [] # Since the amount of each product need to add tax, I create another array Product_arr[] to store it, and it need to be ass in success method, so it is a global variable avaliable all app

  def show_cart_detail
    @products = Product.find(session[:cart])
  end

  def create
    products = Product.find(session[:cart]) # find的参数如果是一个，就返回一个值。如果find的参数是一组，那么也返回一个数组

    if products.nil?
      redirect_to root_path
      return
    end

    province = Customer.find_by_user_id(current_user.id).province
    tax_province = Tax.find_by_province(province)
    tax = tax_province.gst + tax_province.pst

    $product_arr = []
    products.each do |item|
      $product_arr << { name: item.name, description: item.description, amount: (item.price * (1 + tax) * 100).to_i, currency: 'CAD', quantity: 1 }
    end

    @session = Stripe::Checkout::Session.create(
      payment_method_types: [:card],
      line_items: $product_arr,
      # [ # This is a array of dictionary, a set of dictionary is a product to pay.
      #   {
      #     name: 'Good Product1',
      #     description: 'Good Product1',
      #     amount: 1545,
      #     currency: 'cad',
      #     quantity: 1
      #   },

      #   {
      #     name: 'Good Product2',
      #     description: 'Good Product2',
      #     amount: 111,
      #     currency: 'cad',
      #     quantity: 1
      #   }

      # ],
      success_url: checkout_success_url + '?session_id={CHECKOUT_SESSION_ID}',
      cancel_url: checkout_cancel_url
    )

    respond_to do |format|
      format.js
    end
  end

  def success
    # session[:cart] = []
    # load_cart
    @session = Stripe::Checkout::Session.retrieve(params[:session_id])
    @payment_intent = Stripe::PaymentIntent.retrieve(@session.payment_intent)

    # redirect_to create_orders_path($product_arr) # don't konw how to pass the array by path. this doesn't work.

    redirect_to create_orders_path # without pass params, using $product_arr global variable to pass purchasing products.
  end

  def cancel; end
end
