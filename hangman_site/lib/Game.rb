class Game
    dictionary =  File.read "5desk.txt"
    $dictionary_array = dictionary.split(" ")
    attr_accessor :guess_display, :guess_output, :past_guesses, :guesses_left
    def initialize()
        
        @guesses_left = 10
        @random_word = ""
        while @random_word.length <5 || @random_word.length > 12
            @random_word = $dictionary_array[rand($dictionary_array.length - 1)].downcase
        end
        
        @past_guesses = ""
        @guess_display = ""
        @guess_output = ""
        @guess_display  = @guess_display.rjust(@random_word.length * 2,"_ ")
        @guess_removed = @random_word
        @original_random_word = @random_word
    end
    
    def check_guess(guess)
        if guess.length != 1 || guess.match?(/[a-zA-Z]/) != true || @past_guesses.match?(guess) == true
            if @past_guesses.match?(guess) == true
                @guess_output = "You have already guessed that letter! Please choose again"
            elsif guess == "save"
                save
            else
                @guess_output = "Guess must be one letter, please choose again"
            end
            return false
        else
            return true
        end
    end
    
    
    def save
        filename = gets.chomp
        savefile = File.new("save.yaml","w")
        savefile.puts YAML.dump(self)
        puts "quit?"
        if gets.chomp == "yes"
            exit
        else
            return
        end
    end
    def makeGuess(guess)
        if check_guess(guess) == false
            return
        else
            @past_guesses += guess
            @past_guesses = @past_guesses.split('').sort!.join
            
            if @random_word.match(guess) != nil
                while @guess_removed.index(guess) != nil
                    @guess_display[(@random_word.index(guess) * 2)] = guess
                    @guess_removed = @guess_removed.sub(guess,"")
                    @random_word = @random_word.sub(guess,"_")
                end
            else
                @guess_output = "No occurences of #{guess}, sorry!"
                @guesses_left -= 1
                if @guesses_left == 0
                    @guess_output = "Sorry you lose.  The word was #{@original_random_word}"
                end
            end
            if @guess_removed == ""
                @guess_output = "Congratulations you win!"
            end
        end
    end
end

def new_game?
    initialize
end