require "game"

RSpec.describe Game do
  describe "#anagram" do
    it "returns an anagram of a given answer" do
      game = Game.new(answer: "RUBY")

      aggregate_failures do
        expect(game.anagram.size).to eq 4
        expect(game.anagram.split("").sort).to match_array(%w(B R U Y))
        expect(game.anagram).to_not eq("RUBY")
      end
    end

    it "returns an anagram of a given answer that does not match the original answer" do
      game = Game.new(answer: "PYTHON")

      aggregate_failures do
        expect(game.anagram.size).to eq 6
        expect(game.anagram.split("").sort).to match_array(%w(H N O P T Y))
        expect(game.anagram).to_not eq("PYTHON")
      end
    end

    it "returns an anagram of a palindrome, that is not itself" do
      game = Game.new(answer: "ABCDCBA")

      aggregate_failures do
        expect(game.anagram.size).to eq 7
        expect(game.anagram.split("").sort).to match_array(%w(A A B B C C D))
        expect(game.anagram).to_not eq("ABCDCBA")
      end
    end

    it "returns an anagram of a palindrome, that is not itself, even when called many times" do
      game = Game.new(answer: "ABA")

      aggregate_failures do
        20.times do
          anagram = game.anagram
          expect(anagram).to_not eq("ABA")
          expect(anagram).to_not be_nil
          expect(anagram.size).to eq 3
          expect(anagram.split("").sort).to match_array(%w(A A B))
        end
      end
    end
  end

  describe "#start" do
    let(:output) { StringIO.new }

    it "prints out an anagram" do
      input = StringIO.new
      game = Game.new(answer: "RUBY", input: input, output: output)
      game.start

      game_output_lines = output.string.split("\n")

      expect(game_output_lines[0]).to eq "Let's play a game"
      expect(game_output_lines[1]).to match(/^Guess a word from an anagram [RUBY]{4}$/)
    end

    it "accepts a correct guess" do
      input = StringIO.new("RUBY") # We prepopulate inputs in advance, it's a slightly unusual way to test them
      game = Game.new(answer: "RUBY", input: input, output: output)
      game.start

      game_output_lines = output.string.split("\n")

      expect(game_output_lines.count).to eq 3
      expect(game_output_lines[2]).to eq "You win! The answer is RUBY."
    end

    it "can be won with some incorrect guesses" do
      guesses = ["ONE", "TWO", "RUBY"]
      input = StringIO.new(guesses.join("\n")) # We prepopulate inputs in advance, it's a slightly unusual way to test them
      game = Game.new(answer: "RUBY", input: input, output: output, max_attempts: 3)

      game.start

      game_output_lines = output.string.split("\n").map(&:strip)

      aggregate_failures do
        expect(game_output_lines.size).to eq 7
        expect(game_output_lines[2]).to eq "The answer is not ONE."
        expect(game_output_lines[3]).to eq "Try again. Attempts left: 2"
        expect(game_output_lines[4]).to eq "The answer is not TWO."
        expect(game_output_lines[5]).to eq "Try again. Attempts left: 1"
        expect(game_output_lines[6]).to eq "You win! The answer is RUBY."
      end
    end

    it "is lost with all incorrect guesses" do
      guesses = ["ONE", "TWO", "THREE"]
      input = StringIO.new(guesses.join("\n")) # We prepopulate inputs in advance, it's a slightly unusual way to test them
      game = Game.new(answer: "RUBY", input: input, output: output, max_attempts: 3)

      game.start

      game_output_lines = output.string.split("\n").map(&:strip)

      aggregate_failures do
        expect(game_output_lines.size).to eq 8
        expect(game_output_lines[2]).to eq "The answer is not ONE."
        expect(game_output_lines[3]).to eq "Try again. Attempts left: 2"
        expect(game_output_lines[4]).to eq "The answer is not TWO."
        expect(game_output_lines[5]).to eq "Try again. Attempts left: 1"
        expect(game_output_lines[6]).to eq "The answer is not THREE."
        expect(game_output_lines[7]).to eq "You lost."
      end
    end
  end
end
