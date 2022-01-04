class SessionSerializer < ActiveModel::Serializer
  attributes :id, :title, :categories, :created_at, :updated_at

  def categories
    object.categories.map do |category|
      {
        id: category.id,
        title: category.title
      }
    end
  end
end
