class Session < ApplicationRecord
  belongs_to :program
  has_many :categories, dependent: :destroy
  has_many :lessons, dependent: :destroy
  has_many :units, dependent: :destroy

  accepts_nested_attributes_for :categories, allow_destroy: true

  def reject_categories(attributes)
    attributes['title'].blank?
  end

  validates :title, presence: true, length: { minimum: 6 }, allow_nil: false
end
