class Program < ApplicationRecord
  has_and_belongs_to_many :users
  has_many :sessions, dependent: :destroy

  accepts_nested_attributes_for :sessions, allow_destroy: true

  def reject_sessions(attributes)
    attributes['title'].blank?
  end

  validates :title, presence: true, length: { minimum: 6 }, allow_nil: false
end
