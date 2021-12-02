class Lesson < ApplicationRecord
  belongs_to :session
  belongs_to :category, options: true # category_id can null
  belongs_to :unit
  has_many :presentations
  has_many :resources
end
