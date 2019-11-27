# frozen_string_literal: true

class CheckoutController < ApplicationController
  def show_cart_detail
    @products = Product.find(session[:cart])
  end

  def create
    products = Product.find(session[:cart]) # find的参数如果是一个，就返回一个值。如果find的参数是一组，那么也返回一个数组

    if products.nil?
      redirect_to root_path
      return
    end

    product_arr = []
    products.each do |item|
      product_arr << { name: item.name, description: item.description, amount: 124, currency: 'CAD', quantity: 1 }
    end

    @session = Stripe::Checkout::Session.create(
      payment_method_types: [:card],
      line_items: product_arr,
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
    session[:cart] = []
    load_cart

    @session = Stripe::Checkout::Session.retrieve(params[:session_id])
    @payment_intent = Stripe::PaymentIntent.retrieve(@session.payment_intent)
  end

  def cancel; end
end
