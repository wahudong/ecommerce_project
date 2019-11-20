# frozen_string_literal: true

class Product < ApplicationRecord
  has_many :sold_products
  belongs_to :category
  validates :name, presence: true
  # paginates_per 10 # Set the pagination items per page
  has_one_attached :image

  def resize
    image.variant(resize_to_limit: [100, 100])
  end
end
