require "sinatra"
#require "sinatra/reloader"
require "./lib/Game.rb"

game = Game.new
game_started = false


get '/' do
    guess = params["guess"]

    if guess == nil
        guess = ""
    else
        guess.downcase!
    end
    if params["new_game"] == true
        game = game.new
        params["new_game"] = false
    end
    if game_started
        game.makeGuess(guess)
    else
        game_started = !game_started
    end
    guess_output = game.guess_output
    guess_display = game.guess_display
    past_guesses = game.past_guesses
    guesses_left = game.guesses_left
    game_won = game.game_won
    if guesses_left == 0 || game_won
        game_started = false
    end
 
    
    erb :index, :locals => {:guess_output => guess_output, :guess_display => guess_display, :past_guesses => past_guesses, :guesses_left => guesses_left, :game_won => game_won, :game => game}
end

    