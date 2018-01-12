require 'sinatra'
require 'sinatra/reloader'

SECRET_NUMBER = rand(100)

def check_guess(guess)
  guess = guess.to_i
  if guess > SECRET_NUMBER
    return "Way too high!" if guess > (SECRET_NUMBER + 5)
    return "Too high!"
  elsif guess < SECRET_NUMBER
    return "Way too low!" if guess < (SECRET_NUMBER - 5)
    return "Too low!"
  else
    return "Your guess is correct!"
  end
end

def display_answer(guess)
  if guess.to_i == SECRET_NUMBER
    return guess
  else
    return "???"
  end
end

get '/' do
  guess = params["guess"]
  message = check_guess(guess)
  number = display_answer(guess)
  erb :index, :locals => {
    :number => number, 
    :message => message
  }
end