require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'
require './lib/question'
require "./lib/survey"
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
  redirect ('/create_survey')
end

get '/edit_survey/:id' do
  survey_id = params.fetch('id').to_i
  @survey = Survey.find(survey_id)
  @questions = Question.all.where({:survey_id => survey_id})
  erb :edit_survey
end

post '/edit_survey_title' do
  title = params.fetch('title')
  id = params.fetch('id').to_i
  survey = Survey.find(id)
  @survey = survey.update({:name => title})
  redirect ("/edit_survey/#{@survey.id}")
end

post '/create_question' do
  question = params.fetch('question')
  survey_id = params.fetch('survey_id').to_i
  @question = Question.create({:question => question, :survey_id => survey_id})
  redirect ("/edit_survey/#{survey_id}")
end
