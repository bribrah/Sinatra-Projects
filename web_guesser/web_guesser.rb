require "sinatra"
require "sinatra/reloader"
require "erb"

SECRET_NUMBER = rand(100)
guess_output = ""

get '/' do
    guess = params["guess"].to_i
    guess_output = guess(guess)
    erb :index, :locals => {:guess_output =>guess_output}
end

def guess(num)
    if num - SECRET_NUMBER > 5
        "This guess is  way too high"
    elsif num - SECRET_NUMBER > 0
        "This guess was a little too high"
    elsif num - SECRET_NUMBER < -5
        "This guess was way to low"
    elsif num - SECRET_NUMBER < 0
        "This guess was a little to low"
    else
        "You are correct!\n The Number was #{SECRET_NUMBER}"
    end
end

        