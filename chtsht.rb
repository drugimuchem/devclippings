require 'sinatra'
require 'slim'
require './lib/cheatsheet'
require 'mongoid'
require 'pp'

configure do
  Mongoid.load!("mongoid.yml",:development)
  #Mongoid.load!("mongoid.yml",:production)
end

get '/' do
  @shts = Cheatsheet.all
  slim :index
end

get '/new' do
  @sht = Cheatsheet.new
  slim :form
end

get '/edit/:id' do |id|
  @sht = Cheatsheet.find(id)
  slim :form
end

get '/show/:id' do |id|
  @sht = Cheatsheet.find(id)
  slim :show
end

get '/delete/:id' do |id|
  Cheatsheet.find(id).delete
  redirect to('/')
end

post '/save' do
  cs = Cheatsheet.find_or_initialize_by(id: params[:id])
  cs.update_attributes(params[:sheet])
  redirect to("/show/#{cs.id}")
end
