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
    if answers.size == 1
      word_anagram = "anagram"
    else
      word_anagram = "anagrams"
    end
    output.puts "Let's play a game. You will have to guess #{answers.size} #{word_anagram}."
    answers.each.with_index(1) do |answer, index|
      output.puts "#{index}/#{answers.size}. Guess a word from an anagram #{Anagram.create("#{answer}")}"
      evaluate_user_guesses
    end
    output.puts "Your final score: #{correct_answers}/#{answers.size}."

  end


  def evaluate_user_guesses
    guess = nil
    current_attempt = 1
    while guess != answers[-1] && current_attempt <= max_attempts
      guess = input.gets.to_s.strip
      if guess == answers[-1]
        output.puts "Correct! The answer is #{answers[-1]}."
        @correct_answers += 1
        output.puts "So far you have correctly guessed #{correct_answers} out of #{answers.size}."
      else
        output.puts "The answer is not #{guess}."
        if current_attempt < max_attempts
          output.puts "Try again. Attempts left: #{max_attempts - current_attempt}" # Generic approach that works for both cases
        else
          output.puts "You lost."
        end
      end

      current_attempt += 1
    end

  end

  private

  attr_reader :answers, :correct_answers, :input, :max_attempts, :output
end
