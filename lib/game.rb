class Game
  attr_accessor :answer
  def initialize(answer:)
    @answer = answer
  end

  def anagram
    answer = @answer.split("").shuffle.join
    answer2 = @answer.split("").join
    answer if answer != answer2
  end
end
