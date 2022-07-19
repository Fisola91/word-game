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
   # implement me and any other methods you feel like you need
   output.puts "Let's play a game. You will have to guess 1 anagram."
   output.puts "1/1. Guess a word from an anagram #{Anagram.create("#{answers.join}")}"

   evaluate_user_guesses
  end

  def evaluate_user_guesses
    guess = nil
    current_attempt = 1
    guess_counts = 1
    scores = 1
    max_attempts_count = 3
    while guess != answers.join && current_attempt <= max_attempts
      guess = input.gets.to_s.strip

      if guess == answers.join
        output.puts "Correct! The answer is #{answers.join}."
      else
        output.puts "The answer is not #{guess}."
      end

      if guess == answers.join && current_attempt < max_attempts
        output.puts "So far you have correctly guessed #{guess_counts} out of #{scores}."
      else
        output.puts "Try again. Attempts left: #{max_attempts_count -= 1}"
      end
      # if guess != answers.join && current_attempt < max_attempts
      # end
      # guess_counts += 1
      # scores += 1

      current_attempt += 1
    end
    output.puts "Your final score: 1/1."
  end

  private

  attr_reader :answers, :correct_answers, :input, :max_attempts, :output
end
