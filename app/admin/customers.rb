# frozen_string_literal: true

ActiveAdmin.register Customer do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :name, :login_name, :password, :street_no, :street_name, :city, :province, :postal_code, :email, :phone, :user_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :login_name, :password, :street_no, :street_name, :city, :province, :postal_code, :email, :phone, :user_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
end
