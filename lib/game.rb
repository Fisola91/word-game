class Game
  attr_accessor :answer
  def initialize(answer:)
    @answer = answer
  end

  def anagram
    @answer.split("").shuffle.join
  end
end
