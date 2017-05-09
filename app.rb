require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'
require "./lib/survey"
require './lib/question'
require './lib/answer'
require 'pry'


also_reload('lib/**/*.rb')


get '/' do
  erb :index
end

get '/create_survey' do
  @surveys = Survey.all
  erb :create_survey
end

post '/survey_title' do
  title = params.fetch('title')
  @survey = Survey.create({:name => title})
  redirect '/create_survey'
end

get '/edit_survey/:id' do
  survey_id = params.fetch('id').to_i
  @survey = Survey.find(survey_id)
  @questions = Question.all.where({:survey_id => survey_id})
  erb :edit_survey
end

patch '/edit_survey_title/:id' do
  title = params.fetch('title')
  id = params.fetch('id').to_i
  survey = Survey.find(id)
  @survey = survey.update({:name => title})
  redirect "/edit_survey/#{survey.id}"
end

post '/create_question' do
  question = params.fetch('question')
  survey_id = params.fetch('survey_id').to_i
  @question = Question.create({:question => question, :survey_id => survey_id})
  redirect "/edit_survey/#{survey_id}"
end

delete '/delete_survey/:id' do
  id = params.fetch('id').to_i
  survey = Survey.find(id)
  survey.destroy
  redirect "/create_survey"
end

get '/edit_survey/:id/edit_question/:question_id' do
  survey_id = params.fetch('id').to_i
  question_id = params.fetch('question_id').to_i
  @survey = Survey.find(survey_id)
  @question = Question.find(question_id)
  @answers = Answer.all.where({:question_id => question_id})
  erb :edit_question
end

patch '/edit_survey/:survey_id/edit_question/:question_id' do
  new_question = params.fetch('question')
  question_id = params.fetch('question_id').to_i
  survey_id = params.fetch('survey_id').to_i
  @survey = Survey.find(survey_id)
  question = Question.find(question_id)
  @question = question.update({:question => new_question})
  redirect "/edit_survey/#{survey_id}/edit_question/#{question_id}"
end

delete '/:survey_id/delete_question/:id' do
  survey_id = params.fetch('survey_id').to_i
  id = params.fetch('id').to_i
  question = Question.find(id)
  question.delete
  redirect "/edit_survey/#{survey_id}"
end

post '/:survey_id/:question_id/create_answer' do
  answer = params.fetch('answer')
  survey_id = params.fetch('survey_id').to_i
  question_id = params.fetch('question_id').to_i
  @answer = Answer.create({:answer => answer, :question_id => question_id})
  redirect "/edit_survey/#{survey_id}/edit_question/#{question_id}"
end
