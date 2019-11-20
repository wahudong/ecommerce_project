# frozen_string_literal: true

class SoldProduct < ApplicationRecord
  belongs_to :order
  belongs_to :product
  validates :order, presence: true
  validates :product, presence: true
end
