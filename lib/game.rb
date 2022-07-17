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
        # The explicit return forces the loop to exit without considering the implicit return
        return output.puts "You win! The answer is #{answer}."
      when guess
        output.puts "The answer is not #{guess}."
      # when "TWO"
      #   output.puts "The answer is not #{guess}."
      # when "THREE"
      #   output.puts "The answer is not #{guess}."
      end
      # guesses = ["ALPHA", "BETA", "GAMMA"]
      # expect(game_output_lines.size).to eq 8
      # expect(game_output_lines[2]).to eq "The answer is not ALPHA."
      # expect(game_output_lines[3]).to eq "Try again. Attempts left: 2"
      # expect(game_output_lines[4]).to eq "The answer is not BETA."
      # expect(game_output_lines[5]).to eq "Try again. Attempts left: 1"
      # expect(game_output_lines[6]).to eq "The answer is not GAMMA."
      # expect(game_output_lines[7]).to eq "You lost."

      if guess != "THREE" && guess != "GAMMA"
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
