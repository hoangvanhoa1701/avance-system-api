class UnitSerializer < ActiveModel::Serializer
  attributes :id, :title, :created_at, :updated_at
end
