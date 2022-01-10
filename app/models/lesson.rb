class Lesson < ApplicationRecord
  belongs_to :session, optional: true # session_id can null
  belongs_to :category, optional: true # category_id can null
  belongs_to :unit, optional: true # unit_id can null
  has_many :presentations
  has_many :resources
end
