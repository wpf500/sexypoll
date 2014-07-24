require 'sinatra'
require 'sinatra/cross_origin'
require_relative 'init'


configure do
  enable :cross_origin
end

get '/' do
  send_file('./public/index.html')
end

before '/api/*' do
  content_type :json
end

get '/api/quizzes' do
  Quiz.all.map { |m| m.as_document }.to_json
end

post '/api/quizzes' do
  data = ActiveSupport::JSON.decode(params[:data])
  Quiz.create(data).to_json
end

get '/api/quizzes/:id' do |id|
  Quiz.find(id).to_json
end

patch '/api/quizzes/:id' do |id|
  data = ActiveSupport::JSON.decode(params[:data])
  Quiz.find(id).update_attributes(data).to_json
end

delete '/api/quizzes/:id' do |id|
  Quiz.find(id).delete
end

get '/api/users' do
  User.all.map { |m| m.as_document }.to_json
end

get '/api/users/:id' do |id|
  User.find(id).to_json
end

post '/api/users' do
  User.create.to_json
end

post '/api/users/:user_id/answers' do |user_id|
  data = ActiveSupport::JSON.decode(params[:data])
  if answer = User.find(user_id).answers.find_by(quiz_id: data['quiz_id'])
    answer.update_attributes(data).to_json
  else
    User.find(user_id).answers.create(data).to_json
  end
end

patch '/api/users/:user_id/answers/:answer_id' do |user_id, answer_id|
  data = ActiveSupport::JSON.decode(params[:data])
  User.find(user_id).answers.find(answer_id).update_attributes(data).to_json
end

get '/api/users/:user_id/answers' do |user_id|
  User.find(user_id).answers.all.map { |m| m.as_document }.to_json
end

get "/api/users/:user_id/results/:quiz_id/:number_of_questions" do |user_id, quiz_id, number_of_questions|
  # Get answers
  # user = User.find(user_id)
  # user_answer = User.find(user_id).answers.where(quiz_id: quiz_id).first.user_answers
  answers = User.all.map {|user|
    if q = user.answers.where(quiz_id: quiz_id).first
      q.user_answers
    else
      nil
    end
  }.reject(&:nil?)

  if number_of_questions == '1'
    answers
      .map(&:first).inject(Hash.new(0)) {|h,i| h[i] += 1; h }.to_json
  else
    user_answer = User.find(user_id).answers.find_by(quiz_id: quiz_id).user_answers
    answers.select {|answer| answer.take(number_of_questions.to_i).drop(1) == user_answer.take(number_of_questions.to_i).drop(1)}
      .map(&:first).inject(Hash.new(0)) {|h,i| h[i] += 1; h }.to_json
  end

end

