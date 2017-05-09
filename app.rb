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

get '/edit_surveys/:id' do
  survey_id = params.fetch('id')
  @survey = Survey.find(survey_id)
  erb :edit_surveys
end
