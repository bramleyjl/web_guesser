require 'sinatra'
require 'sinatra/reloader'

rand_num = rand(100)

get '/'  do
	"The SECRET NUMBER is #{rand_num}"
end