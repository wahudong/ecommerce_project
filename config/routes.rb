# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  get 'page/index'
  get 'page/show'
  # get 'products/index'
  # get 'products/show'

  get 'product/products_by_category', to: 'products#products_by_category'
  post 'product/ptoructs_by_filter', to: 'products#products_by_filter'

  resources :products, only: %i[index show] do
    collection do
      get 'search_results'
    end
  end

  post 'products/add_to_cart/:id', to: 'products#add_to_cart', as: 'add_to_cart'
  delete 'products/remove_from_cart/:id', to: 'products#remove_from_cart', as: 'remove_from_cart'

  get 'static/:permalink', to: 'page#permalink', as: 'permalink'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  root to: 'products#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
