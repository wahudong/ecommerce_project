# frozen_string_literal: true

class Order < ApplicationRecord
  has_many :sold_products
  belongs_to :customer
end
