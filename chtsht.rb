require 'sinatra'
require 'haml'

get '/' do
  haml :index
end

get '/new' do
  haml :new
end

post '/save' do
  haml :new
  redirect to('/')
end
