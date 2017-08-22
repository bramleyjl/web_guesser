require 'sinatra'
require 'sinatra/reloader'

@@secret_number = rand(100)
@@guesses_remain = 5

def check_guess(guess)
	guess = guess.to_i
	if guess == @@secret_number
		restart(true)
		return "Your guess is correct! You win! Guess again to start over with a new number."
	elsif @@guesses_remain == 0
		restart(false)
		return "You lose! Guess again to start over with a new number."
	elsif guess > (@@secret_number + 5)
		return "Your guess is way too high! You have #{@@guesses_remain} guesses left!"
	elsif guess < (@@secret_number - 5)
		return "Your guess is way too low! You have #{@@guesses_remain} guesses left!"
	elsif guess > @@secret_number
		return "Your guess is too high! You have #{@@guesses_remain} guesses left!"
	elsif guess < @@secret_number
		return "Your guess is too low! You have #{@@guesses_remain} guesses left!"
	end
end

def restart(correct)
	if correct == true
		set_color(9000)
	end
	@@secret_number = rand(100)
	@@guesses_remain = 5
end

def display_answer(guess)
	if guess.to_i == @@secret_number
		return guess
	else
		@@guesses_remain -= 1
	 	return "???"
	end
end

def set_color(guess)
	guess = guess.to_i
	if guess > (@@secret_number + 5) || guess < (@@secret_number - 5)
		return "red"
	elsif guess > @@secret_number || guess < @@secret_number
		return "pink"
	elsif guess == @@secret_number || guess == 9000
		return "green"
	end
end

get '/' do
	guess = params["guess"]
	message = check_guess(guess)
	answer = display_answer(guess)
	background = set_color(guess)
	erb :index, :locals => {:answer => answer, :message => message, :background => background}
end