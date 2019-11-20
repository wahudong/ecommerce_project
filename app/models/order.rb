# frozen_string_literal: true

class Order < ApplicationRecord
  has_many :sold_products
  belongs_to :customer
  validates :customer, presence: true
  validates :province, presence: true
  validates :city, presence: true
  validates :street_name, presence: true
  validates :street_no, presence: true
end
