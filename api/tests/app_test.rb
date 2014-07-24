ENV['RACK_ENV'] = 'test'

require "minitest/autorun"
require 'rack/test'
require 'json'
require_relative '../app'

class AppTest < MiniTest::Unit::TestCase
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_default_route_serves_page
    get '/'

    assert(last_response.ok?)
    assert(last_response.body.include?('Super Fun Poll'))
  end

  def test_create_quiz
    post "/api/model/quiz/", params: {data: example_quiz}
    answer = JSON.parse(last_response.body)
    puts answer
    assert_equal(example_quiz.to_json, answer)
  end

  def test_get_quiz
    get "/api/model/quiz/53c3e551a60b486452000001"
    answer = JSON.parse(last_response.body)

    assert_equal('How old are you?', answer['questions'][0]['question'])
  end

  def test_update_quiz
    get "/api/model/quiz/"
    answer = JSON.parse(last_response.body)
    quiz_id = answer.first['_id']
    quiz = answer.first

    patch "/api/model/quiz/#{quiz_id}", {data: answer.first + {hey: 'hey'}}
    assert_equal(answer.first + {hey: 'hey'}, Quiz.find(quiz_id).as_document)
  end
end