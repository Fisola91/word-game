class Game
  attr_accessor :answer
  def initialize(answer:)
    @answer = answer
  end

  def anagram
    @answer.split("").reverse.each do |answer|
      answer
    end.join
  end
end
