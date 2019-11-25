# frozen_string_literal: true

class ProductsController < ApplicationController
  # before_action :initialize_session
  # before_action :load_cart

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

  def products_by_filter
    # @products_by_filter = Product.find_by(on_sale: true) # find only get one record, so not good in this case

    if params[:filter_option] == 'On sale'
      @products_by_filter = Product.where('on_sale = ?', true)
    elsif params[:filter_option] == 'New'
      # ('created_at < ?', 7.days.ago)
      @products_by_filter = Product.where('created_at > ?', 7.days.ago)
    elsif params[:filter_option] == 'Recently Updated'
      @products_by_filter = Product.where('updated_at > ?', 7.days.ago)

    end
  end

  def add_to_cart
    session[:cart] << params[:id] unless session[:cart].include?(params[:id])
    @product = Product.find(params[:id])
    redirect_to @product
  end

  def show_cart_detail
    @products = Product.find(session[:cart])
  end

  def remove_from_cart
    id = params[:id]
    session[:cart].delete(id)
    redirect_to root_path
    # redirect_to show
  end

  private

  #   def initialize_session
  #     session[:cart] ||= []
  #   end

  #   def load_cart
  #     @cart = Product.find(session[:cart])
  #   end
end
