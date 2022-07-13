class Game
  attr_accessor :answer
  def initialize(answer:)
    @answer = answer
  end

  def anagram
    shuffle_word = @answer.split("").shuffle.join
    # shuffle_word if shuffle_word != answer

    if shuffle_word != answer
      shuffle_word
    else
      "invalid"
    end
  end
end
