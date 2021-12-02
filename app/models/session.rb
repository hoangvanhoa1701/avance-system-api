class Session < ApplicationRecord
  belongs_to :program
  has_many :categories
  has_many :lessons
  has_many :units
end
