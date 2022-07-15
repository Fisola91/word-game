class Game
  attr_accessor :answer
  def initialize(answer:)
    @answer = answer
  end

  def start
  end

  def anagram
    shuffle_word = shuffle(answer)
    while answer == shuffle_word
      shuffle_word = shuffle(answer)
      p "#{shuffle_word} : #{answer}"
    end
    shuffle_word
  end

  private

  def shuffle(word)
    word.split("").shuffle.join
  end
end
