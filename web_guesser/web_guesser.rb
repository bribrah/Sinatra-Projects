require "sinatra"
require "sinatra/reloader"
require "erb"

@@secret_number = rand(100)
guess_output = ""
@@guesses_left = 5

get '/' do
    guess = params["guess"].to_i
    backgroundColor = backgroundColor(guess)
    guess_output = guess(guess)
    erb :index, :locals => {:guess_output =>guess_output, :backgroundColor => backgroundColor}
end
def backgroundColor(num)
    if num - @@secret_number > 5 or num - @@secret_number < -5
        "background: red"
    elsif num != @@secret_number
        "background: salmon"
    else
        "background: green"
    end
end

def guess(num)
    @@guesses_left -= 1
    
    if num == @@secret_number
        @@guesses_left = 5
        @@secret_number = rand(100)
        "You are correct! The Number was #{@@secret_number}"
    elsif @@guesses_left == 0
        @@guesses_left = 5
        @@secret_number = rand(100)
        "You ran out of guesses!"
    elsif num - @@secret_number > 5
        "This guess is  way too high, , #{@@guesses_left} guesses left"
    elsif num - @@secret_number > 0
        "This guess was a little too high, #{@@guesses_left} guesses left"
    elsif num - @@secret_number < -5
        "This guess was way to low, #{@@guesses_left} guesses left"
    elsif num - @@secret_number < 0
        "This guess was a little to low, #{@@guesses_left} guesses left"

    end
end

        