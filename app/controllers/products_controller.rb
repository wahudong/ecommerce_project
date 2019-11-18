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
    @category_id = params[:category] # params[:category] contain the category id from the search form dropdown list
    @products = Product.where('name LIKE ? AND category_id = ?', "%#{@query_word}%", @category_id.to_s)
  end

  def products_by_category # come here from the category dropdown list in the navbar
    @category = Category.find_by_name(params[:name])
    # @products = Product.find_by_category_id(@category.id)
    @products_by_cate = Product.where('category_id = ?', @category.id.to_s)
  end
end
