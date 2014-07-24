require_relative 'init'
require 'rest-client'

def root
    "http://localhost:4567"
end

def remote_root
  "http://ancient-chamber-5314.herokuapp.com/"
end
# puts Quiz.count
# puts RestClient.post("#{root}/api/model/quiz", {data: example_quiz})
# puts Quiz.count

# puts RestClient.patch("#{root}/api/model/quiz/53c3e551a60b486452000001", {data: example_quiz.merge!(test: 'testtest')})

# RestClient.post("#{root}/api/quizzes", {data: example_quiz})

answers = [
  ['Yes', 'Blah', 'No'],
  ['Yes', 'Blah', 'No'],
  ['Yes', 'Blah', 'No'],
  ['Yes', 'Blah', 'No'],
  ['Yes', 'Blah', 'No'],
  ['No', 'Blah', 'Yes'],
  ['Yes', 'Blah', 'No'],
  ['Yes', 'Blah', 'No'],
  ['No', 'Blah', 'No'],
  ['Yes', 'Blah', 'No'],
]

# two if answered three questions

# results = answers.transpose.first.inject(Hash.new(0)) {|h,i| h[i] += 1; h }
# puts results
# results = {'Yes' => 8, 'No': 2 }
question_number = 2
user_answer = ['Yes', 'Blah', 'No']
# results = answers.select {|answer| answer[question_number - 1] == user_answer}
results = answers.select {|answer| answer.take(question_number).drop(1) == user_answer.take(question_number).drop(1)}
# pp results
results = results.map(&:first).inject(Hash.new(0)) {|h,i| h[i] += 1; h }



  #.transpose.first.inject(Hash.new(0)) {|h,i| h[i] += 1; h }

pp results