require 'bcrypt'
class User < ActiveRecord::Base
  include BCrypt
  has_many :urls
  validates :email, presence: true
  validates :email, uniqueness: true
  before_create :encrypt

  def self.authenticate(email,password)
    user = User.find_by_email(email)
    if Password.new(user.password) == password
      return user
    else
      return nil
    end
  end

  def encrypt
    self.password = Password.create(self.password)
  end
end





