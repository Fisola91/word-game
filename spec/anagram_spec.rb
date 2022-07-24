require "anagram"

RSpec.describe Anagram do
  describe ".create" do
    it "returns an anagram of a given answer" do
      anagram = Anagram.create("RUBY")

      aggregate_failures do
        expect(anagram.size).to eq 4
        expect(anagram.split("").sort).to match_array(%w(B R U Y))
        expect(anagram).to_not eq("RUBY")
      end
    end

    it "returns an anagram of a given answer that does not match the original answer" do
      anagram = Anagram.create("PYTHON")

      aggregate_failures do
        expect(anagram.size).to eq 6
        expect(anagram.split("").sort).to match_array(%w(H N O P T Y))
        expect(anagram).to_not eq("PYTHON")
      end
    end

    it "returns an anagram of a palindrome, that is not itself" do
      anagram = Anagram.create("ABCDCBA")

      aggregate_failures do
        expect(anagram.size).to eq 7
        expect(anagram.split("").sort).to match_array(%w(A A B B C C D))
        expect(anagram).to_not eq("ABCDCBA")
      end
    end

    it "returns an anagram of a palindrome, that is not itself, even when called many times" do
      aggregate_failures do
        20.times do
          anagram = Anagram.create("ABA")
          expect(anagram).to_not eq("ABA")
          expect(anagram).to_not be_nil
          expect(anagram.size).to eq 3
          expect(anagram.split("").sort).to match_array(%w(A A B))
        end
      end
    end
  end
end
