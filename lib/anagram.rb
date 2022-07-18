class Anagram
  def self.create(word)
    self.new(word).anagram
  end

  def initialize(word)
    @word = word
  end

  def anagram
    shuffled_word = shuffle_word
    while word == shuffled_word
      shuffled_word = shuffle_word
    end
    shuffled_word
  end

  private

  attr_reader :word

  def shuffle_word
    word.split("").shuffle.join
  end
end
