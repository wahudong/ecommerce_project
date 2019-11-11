# frozen_string_literal: true

class ProductsController < ApplicationController
  def index
    @products = Product.all.page(params[:page]).per(8)
    @categories = Category.all
    # @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

  def search_results
    @query_word = params[:query_word]
    @products = Product.where('name LIKE ?', "%#{@query_word}%")
    @category_id = params[:category]
  end
end
