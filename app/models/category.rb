class Category < ApplicationRecord
  belongs_to :session
  has_many :lessons
  has_many :units
end
