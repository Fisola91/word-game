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
  end

  private

  attr_reader :answers, :correct_answers, :input, :max_attempts, :output
end
