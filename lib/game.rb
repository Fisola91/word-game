class Game
  attr_accessor :answer
  def initialize(answer:)
    @answer = answer
  end

  def anagram
    p @answer.split("").reverse.shuffle.join
  end
end
