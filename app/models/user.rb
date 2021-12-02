class User < ApplicationRecord
  # encrypt password
  has_secure_password

  has_and_belongs_to_many :programs

  validates :email,
            presence: true,
            format: { with: URI::MailTo::EMAIL_REGEXP, message: 'must be a valid email address' },
            uniqueness: { message: 'has already been taken' }
  validates :fullname, presence: true

  enum role: { admin: 0, contentadmin: 1, educator: 2, usernone: 3 }
end
