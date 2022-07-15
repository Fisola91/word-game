class Game
  attr_accessor :answer
  def initialize(answer:)
    @answer = answer
  end

  def start
    # On-going
    # shuffle(word)
    $stdout.puts "Let's play a game"
    # shuffle(answer) if $stdout.string =~ /[A-Z]/


    # array = ["Let's play a game", shuffle(answer)]
    # p array[0]
    # guess_word = shuffle(answer)
    # guess_word

    #  array.each { |ar|  $stdout.puts ar }

  #  .select { |line| line =~ /[A-Z]/ }
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
