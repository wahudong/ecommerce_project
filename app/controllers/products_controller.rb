# frozen_string_literal: true

class ProductsController < ApplicationController
  def index
    @products = Product.all.page(params[:page]).per(8)
    # @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end
end
