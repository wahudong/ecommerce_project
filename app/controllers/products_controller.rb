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
    @category_id = params[:category] # params[:category] contain the category id from the search form
    @products = Product.where('name LIKE ? AND category_id = ?', "%#{@query_word}%", @category_id.to_s)
  end
end
