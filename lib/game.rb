class Game
  attr_accessor :answer
  def initialize(answer:)
    @answer = answer
  end

  def start
    puts "Let's play a game"
    puts "Guess a word from an anagram #{anagram}"
  end

  def anagram
    shuffle_word = shuffle(answer)
    while answer == shuffle_word
      shuffle_word = shuffle(answer)
    end
    shuffle_word
  end

  private

  def shuffle(word)
    word.split("").shuffle.join
  end
end
# game = Game.new(answer: "RUBY")
# game_output_lines = capture_lines { game.start }
