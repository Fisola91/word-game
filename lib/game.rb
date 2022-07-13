class Game
  attr_accessor :answer
  def initialize(answer:)
    @answer = answer
  end

  def anagram
    @answer.split("").reverse.each { |answer| answer }.join
  end
end
