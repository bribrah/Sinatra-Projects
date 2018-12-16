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
    if params["new_game"] == true
        game = game.new
        params["new_game"] = false
    end
    game.makeGuess(guess)
    guess_output = game.guess_output
    guess_display = game.guess_display
    past_guesses = game.past_guesses
    guesses_left = game.guesses_left
    game_won = game.game_won
    
    erb :index, :locals => {:guess_output => guess_output, :guess_display => guess_display, :past_guesses => past_guesses, :guesses_left => guesses_left, :game_won => game_won, :game => game}
end

    