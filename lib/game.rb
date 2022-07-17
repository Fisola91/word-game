class Game
  def initialize(answer:, input: $stdin, output: $stdout, max_attempts: 3)
    @answer = answer
    @input = input
    @output = output
    @max_attempts = 3
  end

  def start
    output.puts "Let's play a game"
    output.puts "Guess a word from an anagram #{anagram}"

    evaluate_user_guesses
  end

  def evaluate_user_guesses
    guess = nil
    current_attempt = 1
    max_attempts_count = 3
    while guess != answer && current_attempt <= max_attempts
      guess = input.gets.to_s.strip # This reads a line of input from the player
      puts guess

      # Implement the rest of the logic here
      case guess
      when answer
        return output.puts "You win! The answer is #{answer}."
      when guess
        output.puts "The answer is not #{guess}."
      end
     if guess != answer && current_attempt < max_attempts
        output.puts "Try again. Attempts left: #{max_attempts_count -= 1}"
      end
      current_attempt += 1
    end
    output.puts "You lost."
  end

  def anagram
    shuffle_word = shuffle(answer)
    while answer == shuffle_word
      shuffle_word = shuffle(answer)
    end
    shuffle_word
  end

  private

  attr_reader :answer, :input, :output, :max_attempts

  def shuffle(word)
    word.split("").shuffle.join
  end
end
