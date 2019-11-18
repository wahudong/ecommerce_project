# frozen_string_literal: true

Rails.application.routes.draw do
  get 'page/index'
  get 'page/show'
  # get 'products/index'
  # get 'products/show'

  get 'product/products_by_category', to: 'products#products_by_category'

  resources :products, only: %i[index show] do
    collection do
      get 'search_results'
    end
  end

  get 'static/:permalink', to: 'page#permalink', as: 'permalink'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  root to: 'products#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
