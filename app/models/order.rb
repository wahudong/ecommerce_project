# frozen_string_literal: true

class Order < ApplicationRecord
  has_many :sold_products
  belongs_to :customer
  validates :customer, presence: true
  validates :province, presence: true
end
