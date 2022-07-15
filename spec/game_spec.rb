require "game"

RSpec.describe Game do
  describe "#anagram" do
    it "returns anagram of a given answer" do
      game = Game.new(answer: "RUBY")

      aggregate_failures do
        expect(game.anagram.size).to eq 4
        expect(game.anagram.split("").sort).to match_array(%w(B R U Y))
        expect(game.anagram).to_not eq("RUBY")
      end
    end

    it "returns a different anagram of a given answer" do
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

    it "returns an anagram of a palindrome, that is not itself" do
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
    it "prints out an anagram" do
      game = Game.new(answer: "RUBY")

      game_output_lines = capture_lines { game.start }

      expect(game_output_lines[0]).to eq "Let's play a game"
      expect(game_output_lines[1]).to match(/^Guess a word from an anagram [RUBY]{4}$/)
    end
  end
end
