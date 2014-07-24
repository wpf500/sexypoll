class Answer
  include Mongoid::Document

  embedded_in :user

  field :quiz_id, type: String
  field :user_answers, type: Array
end