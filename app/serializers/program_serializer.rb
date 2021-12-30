class ProgramSerializer < ActiveModel::Serializer
  attributes :id, :title, :sessions

  def sessions
    object.sessions.map do |session|
      {
        id: session.id,
        title: session.title,
        categories: session.categories
      }
    end
  end

  # has_many :sessions, include: :all
end
