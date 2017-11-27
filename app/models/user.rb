class User < ApplicationRecord
  validates_presence_of :name, :email, :password_digest
  has_many :todos, foreign_key: :created_by
  has_secure_password
end
