# frozen_string_literal: true

class Page < ApplicationRecord
  validates :permalink, presence: true
end
