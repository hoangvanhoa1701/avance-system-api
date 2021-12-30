class Program < ApplicationRecord
  has_and_belongs_to_many :users
  has_many :sessions, dependent: :destroy

  accepts_nested_attributes_for :sessions
end
