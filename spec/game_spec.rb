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
  end
end
