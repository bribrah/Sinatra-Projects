require "sinatra"
require "sinatra/reloader"
require "./lib/Game.rb"

@@guesses_left = ""
@@letters_guessed = ""
@@guess_display = ""
game = Game.new

get '/' do
    guess = params["guess"]
    if guess == nil
        guess = ""
    end
    guess_output = game.makeGuess(guess)
    guess_display = game.guess_display
    
    erb :index, :locals => {:guess_output => guess_output, :guess_display => guess_display}
end

    