class Game
    dictionary =  File.read "5desk.txt"
    $dictionary_array = dictionary.split(" ")
    attr_accessor :guess_display
    def initialize()
        
        @incorrect_guesses = 0
        @random_word = ""
        while @random_word.length <5 || @random_word.length > 12
            @random_word = $dictionary_array[rand($dictionary_array.length - 1)].downcase
        end
        
        @past_guesses = ""
        @guess_display = ""
        @guess_display  = @guess_display.rjust(@random_word.length * 2,"_ ")
        @guess_removed = @random_word
        @original_random_word = @random_word
    end
    
    def check_guess(guess)
        if guess.length != 1 || guess.match?(/[a-zA-Z]/) != true || @past_guesses.match?(guess) == true
            if @past_guesses.match?(guess) == true
                print "You have already guessed that letter! Please choose again:"
            elsif guess == "save"
                save
            else
                print "Guess must be one letter, please choose again: "
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
            
            if @random_word.match(guess) != nil
                while @guess_removed.index(guess) != nil
                    @guess_display[(@random_word.index(guess) * 2)] = guess
                    @guess_removed = @guess_removed.sub(guess,"")
                    @random_word = @random_word.sub(guess,"_")
                end
            else
                return "No occurences of #{guess}, sorry!"
                @incorrect_guesses += 1
                if @incorrect_guesses == 10
                    return "Sorry you lose.  The word was #{@original_random_word}"
                    return
                end
            end
            if @guess_removed == ""
                return "Congratulations you win!"
            end
        end
    end
end