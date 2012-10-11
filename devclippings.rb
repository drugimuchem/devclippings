require 'sinatra'
require 'slim'
require './lib/clipping'

get '/' do
  @shts = Clipping.all
  slim :index
end

get '/new' do
  @sht = Clipping.new
  slim :form
end

get '/edit/:id' do |id|
  @sht = Clipping.get(id)
  slim :form
end

get '/show/:id' do |id|
  @sht = Clipping.get(id)
  slim :show
end

get '/delete/:id' do |id|
  Clipping.get(id).destroy
  redirect to('/')
end

post '/save' do
  if params.has_key?('id')
    cs = Clipping.get(params[:id])
  else
    cs = Clipping.new
  end
  cs.attributes = params[:sheet]
  cs.save
  redirect to("/show/#{cs.id}")
end
