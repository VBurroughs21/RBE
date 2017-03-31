class User < ActiveRecord::Base
  has_secure_password

  has_many :playlists


  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
    validates :first_name, :last_name, :email, presence: true
    validates :first_name, :last_name, length: { minimum: 2 }
    validates :password, length: { minimum: 5 }
    validates :email, uniqueness: { case_sensitive: false }, format: { with: EMAIL_REGEX }
end
