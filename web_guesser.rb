require 'sinatra'
require 'sinatra/reloader'

SECRET_NUMBER = rand(100)

def check_guess(guess)
	guess = guess.to_i
	if guess > (SECRET_NUMBER + 5)
		return "way too high!"
	elsif guess < (SECRET_NUMBER - 5)
		return "way too low!"
	elsif guess > SECRET_NUMBER
		return "too high!"
	elsif guess < SECRET_NUMBER
		return "too low!"
	elsif guess == SECRET_NUMBER
		return "correct!"
	end
end

def display_answer(guess)
	if guess.to_i == SECRET_NUMBER
		return guess
	else
	 	nil
	end
end  

get '/' do
	guess = params["guess"]
	message = check_guess(guess)
	answer = display_answer(guess)
	erb :index, :locals => {:answer => answer, :message => message}
end



