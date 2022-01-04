class ProgramSerializer < ActiveModel::Serializer
  attributes :id, :title, :sessions, :created_at, :updated_at

  # change key from title to :name_test
  # attribute :title, key: :name_test

  def sessions
    object.sessions.map do |session|
      {
        id: session.id,
        title: session.title,
        categories: categories(session.categories)
      }
    end
  end

  def categories(categories)
    categories.map do |category|
      {
        id: category.id,
        title: category.title
      }
    end
  end
end
