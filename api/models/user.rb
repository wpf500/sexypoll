class User
  include Mongoid::Document
  embeds_many :answers
end