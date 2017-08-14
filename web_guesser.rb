require 'sinatra'
require 'sinatra/reloader'

rand_num = rand(100)

get '/'  do
erb :index, :locals => {:rand_num => rand_num}
end