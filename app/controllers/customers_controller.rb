# frozen_string_literal: true

class CustomersController < ApplicationController
  def show
    # @customers = Customer.where('user = ?', current_user)
    # @customers = Customer.where('user_id = ?', current_user.id) # where always returns a collection.
    # current_user 里面是从login session 获取的当前user object，所以包含.email 等property
    # @customer = Customer.find(params[:id]) # 当找不到匹配的时候，find 会产生exception, 所以考虑用where.
    @customer = Customer.where('user_id = ?', params[:id]).limit(1)[0] # where 返回的总是array，所以用[0],只需要第一个。
    redirect_to new_customer_path if @customer.nil?
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update # when click "update" button in edit.html.erb, the form sent to here
    @customer = Customer.find(params[:id])

    if @customer.update(params.require(:customer).permit(:name, :street_no, :street_name, :city, :province, :postal_code, :email, :phone))
      render 'show'
    else
      render 'edit'
    end
    # redirect_to customer_path(@customer) # 与 customers_path不一样。这是传递了当前的一个customer
  end

  def new
    # param = params[:id]
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(params.require(:customer).permit(:name, :street_no, :street_name, :city, :province, :postal_code, :phone))

    @customer.user_id = current_user.id

    @customer.save

    render 'show'
  end
end
