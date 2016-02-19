require 'sinatra'
require 'sinatra/reloader' if development?
require 'slim'
require 'coffee-script'
require 'tilt/coffee'
require 'sass'


set :show_exceptions, :after_handler
set :views, settings.root + '/templates'


before do
  @author = 'Unine'
  @year = 2016
end

get '/' do
  slim :index
end

get '/js/*.js' do
  coffee "../assets/coffee/#{params[:splat].first}".to_sym
end

get '/css/*.css' do
  sass "../assets/stylesheets/#{params[:splat].first}".to_sym
end

not_found do
  body 'Ooops, this page does not exist :('
end

error do
  body 'Ooops, something went wrong :('
end
