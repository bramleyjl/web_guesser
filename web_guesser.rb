require 'sinatra'
require 'sinatra/reloader'

@@secret_number = rand(100)
@@color = 'white'
@@guesses = 5
@@end_message = nil

def check_guess(guess)
  guess = guess.to_i
  @@guesses -= 1
  @@number = '???'
  if @@guesses <= 0
    end_game('lose') unless guess === @@secret_number
  end
  if guess > @@secret_number
    if guess > (@@secret_number + 5)
      @@color = 'red'
      return "Way too high!"
    end
    @@color = 'pink'
    return "Too high!"
  elsif guess < @@secret_number
    if guess < (@@secret_number - 5)
      @@color = 'red'
      return "Way too low!"
    end 
    @@color = 'pink'
    return "Too low!"
  else
    @@color = 'green'
    end_game('win')
    return "Correct!"
  end
end

def end_game(condition)
  if condition === 'win'
    @@end_message = 'You win! Game has been restarted.'
    @@number = @@secret_number
  elsif condition === 'lose'
    @@end_message = 'You lose! Game has been restarted.' 
  end
  @@secret_number = rand(100)
  @@guesses = 5
end

get '/' do
  guess = params["guess"]
  message = check_guess(guess)
  erb :index, :locals => {
    :number => @@number, 
    :message => message,
    :guesses => @@guesses,
    :color => @@color,
    :end_message => @@end_message
  }
end