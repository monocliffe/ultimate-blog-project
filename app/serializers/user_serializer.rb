class UserSerializer < ActiveModel::Serializer
  attributes :id, :forename, :surname, :email
  has_many :posts
end
