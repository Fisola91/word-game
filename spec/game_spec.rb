require "game"
require "tempfile"


RSpec.describe Game do
  describe "#start" do
    let(:output) { StringIO.new }

    it "prints out an anagram" do
      input = StringIO.new
      game = Game.new(answers: ["RUBY"], input: input, output: output)
      game.start

      game_output_lines = output.string.split("\n")

      expect(game_output_lines[0]).to eq "Let's play a game. You will have to guess 1 anagram."
      expect(game_output_lines[1]).to match(/^1\/1. Guess a word from an anagram [RUBY]{4}$/)
    end

    it "accepts a correct guess" do
      input = StringIO.new("RUBY") # We prepopulate inputs in advance, it's a slightly unusual way to test them
      game = Game.new(answers: ["RUBY"], input: input, output: output)
      game.start

      game_output_lines = output.string.split("\n")

      expect(game_output_lines.count).to eq 5
      expect(game_output_lines[2]).to eq "Correct! The answer is RUBY."
      expect(game_output_lines[3]).to eq "So far you have correctly guessed 1 out of 1."
      expect(game_output_lines[4]).to eq "Your final score: 1/1."
    end

    it "can be won with two incorrect guesses" do
      guesses = ["ONE", "TWO", "RUBY"]
      input = StringIO.new(guesses.join("\n")) # We prepopulate inputs in advance, it's a slightly unusual way to test them
      game = Game.new(answers: ["RUBY"], input: input, output: output, max_attempts: 3)

      game.start

      game_output_lines = output.string.split("\n").map(&:strip)

      aggregate_failures do
        expect(game_output_lines.size).to eq 9
        expect(game_output_lines[2]).to eq "The answer is not ONE."
        expect(game_output_lines[3]).to eq "Try again. Attempts left: 2"
        expect(game_output_lines[4]).to eq "The answer is not TWO."
        expect(game_output_lines[5]).to eq "Try again. Attempts left: 1"
        expect(game_output_lines[6]).to eq "Correct! The answer is RUBY."
        expect(game_output_lines[7]).to eq "So far you have correctly guessed 1 out of 1."
        expect(game_output_lines[8]).to eq "Your final score: 1/1."
      end
    end

    it "can be won with one incorrect guess" do
      guesses = ["BURY", "RUBY"]
      input = StringIO.new(guesses.join("\n")) # We prepopulate inputs in advance, it's a slightly unusual way to test them
      game = Game.new(answers: ["RUBY"], input: input, output: output, max_attempts: 3)

      game.start

      game_output_lines = output.string.split("\n").map(&:strip)

      aggregate_failures do
        expect(game_output_lines.size).to eq 7
        expect(game_output_lines[2]).to eq "The answer is not BURY."
        expect(game_output_lines[3]).to eq "Try again. Attempts left: 2"
        expect(game_output_lines[4]).to eq "Correct! The answer is RUBY."
        expect(game_output_lines[5]).to eq "So far you have correctly guessed 1 out of 1."
        expect(game_output_lines[6]).to eq "Your final score: 1/1."
      end
    end

    it "is lost with all incorrect guesses" do
      guesses = ["ONE", "TWO", "THREE"]
      input = StringIO.new(guesses.join("\n")) # We prepopulate inputs in advance, it's a slightly unusual way to test them
      game = Game.new(answers: ["RUBY"], input: input, output: output, max_attempts: 3)

      game.start

      game_output_lines = output.string.split("\n").map(&:strip)

      aggregate_failures do
        expect(game_output_lines.size).to eq 9
        expect(game_output_lines[2]).to eq "The answer is not ONE."
        expect(game_output_lines[3]).to eq "Try again. Attempts left: 2"
        expect(game_output_lines[4]).to eq "The answer is not TWO."
        expect(game_output_lines[5]).to eq "Try again. Attempts left: 1"
        expect(game_output_lines[6]).to eq "The answer is not THREE."
        expect(game_output_lines[7]).to eq "You lost."
        expect(game_output_lines[8]).to eq "Your final score: 0/1."
      end
    end

    it "is lost with a different set of incorrect guesses" do
      guesses = ["ALPHA", "BETA", "GAMMA"]
      input = StringIO.new(guesses.join("\n")) # We prepopulate inputs in advance, it's a slightly unusual way to test them
      game = Game.new(answers: ["RUBY"], input: input, output: output, max_attempts: 3)

      game.start

      game_output_lines = output.string.split("\n").map(&:strip)

      aggregate_failures do
        expect(game_output_lines.size).to eq 9
        expect(game_output_lines[2]).to eq "The answer is not ALPHA."
        expect(game_output_lines[3]).to eq "Try again. Attempts left: 2"
        expect(game_output_lines[4]).to eq "The answer is not BETA."
        expect(game_output_lines[5]).to eq "Try again. Attempts left: 1"
        expect(game_output_lines[6]).to eq "The answer is not GAMMA."
        expect(game_output_lines[7]).to eq "You lost."
        expect(game_output_lines[8]).to eq "Your final score: 0/1."
      end
    end

    it "can be played with multiple words, with a lose and a win" do
      guesses = ["ALPHA", "BETA", "GAMMA", "MEGA", "OMEGA"]
      input = StringIO.new(guesses.join("\n")) # We prepopulate inputs in advance, it's a slightly unusual way to test them
      game = Game.new(answers: ["DELTA", "OMEGA"], input: input, output: output, max_attempts: 3)

      game.start

      game_output_lines = output.string.split("\n").map(&:strip)

      aggregate_failures do
        expect(game_output_lines.size).to eq 14
        expect(game_output_lines[0]).to eq "Let's play a game. You will have to guess 2 anagrams."
        expect(game_output_lines[1]).to match(/^1\/2. Guess a word from an anagram [DELTA]{5}$/)
        expect(game_output_lines[2]).to eq "The answer is not ALPHA."
        expect(game_output_lines[3]).to eq "Try again. Attempts left: 2"
        expect(game_output_lines[4]).to eq "The answer is not BETA."
        expect(game_output_lines[5]).to eq "Try again. Attempts left: 1"
        expect(game_output_lines[6]).to eq "The answer is not GAMMA."
        expect(game_output_lines[7]).to eq "You lost."
        expect(game_output_lines[8]).to match(/^2\/2. Guess a word from an anagram [OMEGA]{5}$/)
        expect(game_output_lines[9]).to eq "The answer is not MEGA."
        expect(game_output_lines[10]).to eq "Try again. Attempts left: 2"
        expect(game_output_lines[11]).to eq "Correct! The answer is OMEGA."
        expect(game_output_lines[12]).to eq "So far you have correctly guessed 1 out of 2."
        expect(game_output_lines[13]).to eq "Your final score: 1/2."
      end
    end

    it "can be played with multiple words, with a win and a lose" do
      guesses = ["ALPHA", "BETA", "GAMMA", "DELTA", "EPSILON"]
      input = StringIO.new(guesses.join("\n")) # We prepopulate inputs in advance, it's a slightly unusual way to test them
      game = Game.new(answers: ["BETA", "OMEGA"], input: input, output: output, max_attempts: 3)

      game.start

      game_output_lines = output.string.split("\n").map(&:strip)

      aggregate_failures do
        expect(game_output_lines.size).to eq 14
        expect(game_output_lines[0]).to eq "Let's play a game. You will have to guess 2 anagrams."
        expect(game_output_lines[1]).to match(/^1\/2. Guess a word from an anagram [BETA]{4}$/)
        expect(game_output_lines[2]).to eq "The answer is not ALPHA."
        expect(game_output_lines[3]).to eq "Try again. Attempts left: 2"
        expect(game_output_lines[4]).to eq "Correct! The answer is BETA."
        expect(game_output_lines[5]).to eq "So far you have correctly guessed 1 out of 2."
        expect(game_output_lines[6]).to match(/^2\/2. Guess a word from an anagram [OMEGA]{5}$/)
        expect(game_output_lines[7]).to eq "The answer is not GAMMA."
        expect(game_output_lines[8]).to eq "Try again. Attempts left: 2"
        expect(game_output_lines[9]).to eq "The answer is not DELTA."
        expect(game_output_lines[10]).to eq "Try again. Attempts left: 1"
        expect(game_output_lines[11]).to eq "The answer is not EPSILON."
        expect(game_output_lines[12]).to eq "You lost."
        expect(game_output_lines[13]).to eq "Your final score: 1/2."
      end
    end

    it "can be played case insensitive" do
      guesses = ["ALPHA", "beta"]
      input = StringIO.new(guesses.join("\n")) # We prepopulate inputs in advance, it's a slightly unusual way to test them
      game = Game.new(answers: ["alpha", "BETA"], input: input, output: output, max_attempts: 3)

      game.start

      game_output_lines = output.string.split("\n").map(&:strip)
      aggregate_failures do
        expect(game_output_lines.size).to eq 8
        expect(game_output_lines[0]).to eq "Let's play a game. You will have to guess 2 anagrams."
        expect(game_output_lines[1]).to match(/^1\/2. Guess a word from an anagram [ALPH]{5}$/)
        expect(game_output_lines[2]).to eq "Correct! The answer is ALPHA."
        expect(game_output_lines[3]).to eq "So far you have correctly guessed 1 out of 2."
        expect(game_output_lines[4]).to match(/^2\/2. Guess a word from an anagram [BETA]{4}$/)
        expect(game_output_lines[5]).to eq "Correct! The answer is BETA."
        expect(game_output_lines[6]).to eq "So far you have correctly guessed 2 out of 2."
        expect(game_output_lines[7]).to eq "Your final score: 2/2."
      end
    end
  end

  describe "#from_file" do
    let(:output) { StringIO.new }

    fit "creates and starts a game from answers written in a file" do
      file = Tempfile.new
      answers = %w(alpha beta)
      file_contents = answers.join("\n")
      begin
        file.write(file_contents)
        file.rewind

        guesses = %w(alpha beta)
        input = StringIO.new(guesses.join("\n"))
        game = Game.from_file(
          path: file.path,
          input: input,
          output: output,
          max_attempts: 3
        )

        game.start

        game_output_lines = output.string.split("\n").map(&:strip)
        aggregate_failures do
          expect(game_output_lines.size).to eq 8
          expect(game_output_lines[0]).to eq "Let's play a game. You will have to guess 2 anagrams."
          expect(game_output_lines[1]).to match(/^1\/2. Guess a word from an anagram [ALPH]{5}$/)
          expect(game_output_lines[2]).to eq "Correct! The answer is ALPHA."
          expect(game_output_lines[3]).to eq "So far you have correctly guessed 1 out of 2."
          expect(game_output_lines[4]).to match(/^2\/2. Guess a word from an anagram [BETA]{4}$/)
          expect(game_output_lines[5]).to eq "Correct! The answer is BETA."
          expect(game_output_lines[6]).to eq "So far you have correctly guessed 2 out of 2."
          expect(game_output_lines[7]).to eq "Your final score: 2/2."
        end
      ensure
        file.close
        file.unlink
      end
    end
  end
end
