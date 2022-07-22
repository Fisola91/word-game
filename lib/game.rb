require_relative "./anagram"

class Game
  def initialize(answers:, input: $stdin, output: $stdout, max_attempts: 3)
    @answers = answers
    @correct_answers = 0
    @input = input
    @max_attempts = 3
    @output = output

  end

  def start
   output.puts "Let's play a game. You will have to guess 1 anagram."
   output.puts "1/1. Guess a word from an anagram #{Anagram.create("#{answers[-1]}")}"
   evaluate_user_guesses
  end


  def evaluate_user_guesses
    guess = nil
    current_attempt = 1
    max_attempts_count = 3
    guess_counts = 1
    scores = 1

    while guess != answers[-1] && current_attempt <= max_attempts
      guess = input.gets.to_s.strip
      if guess == answers[-1]  && current_attempt <= max_attempts
        output.puts "Correct! The answer is #{answers[-1]}."
        @correct_answers += 1
        output.puts "So far you have correctly guessed #{correct_answers} out of #{scores}."
      else
        output.puts "The answer is not #{guess}."
        if current_attempt < max_attempts
          output.puts "Try again. Attempts left: #{max_attempts_count -= 1}" # Generic approach that works for both cases
        else current_attempt == max_attempts
          output.puts "You lost."
        end
      end

      current_attempt += 1
    end
    output.puts "Your final score: #{correct_answers}/#{answers.size}."
  end

  private

  attr_reader :answers, :correct_answers, :input, :max_attempts, :output
end
