class SessionSerializer < ActiveModel::Serializer
  attributes :id, :title, :categories

  has_many :categories, include: :all
end
