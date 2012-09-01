require 'sinatra'
require 'slim'
require './lib/cheatsheet'
require 'pp'

get '/' do
  @shts = Cheatsheet.all
  slim :index
end

get '/new' do
  @sht = Cheatsheet.new
  slim :form
end

get '/edit/:id' do |id|
  @sht = Cheatsheet.get(id)
  slim :form
end

get '/show/:id' do |id|
  @sht = Cheatsheet.get(id)
  slim :show
end

get '/delete/:id' do |id|
  Cheatsheet.get(id).destroy
  redirect to('/')
end

post '/save' do
  puts pp params
  if params.has_key?('id')
    cs = Cheatsheet.get(params[:id])
    cs.update(params[:sheet])
  else
    cs = Cheatsheet.create(params[:sheet])
  end
  redirect to("/show/#{cs.id}")
end
