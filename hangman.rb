# frozen_string_literal: true

require 'open-uri'

# Hangman game
words = URI('https://raw.githubusercontent.com/first20hours/google-10000-english/master/google-10000-english-no-swears.txt').open(&:read).split("\n")
class Game
  def initialize(words)
    @word = words.sample
    @guesses = []
    @wrong_guesses = []
  end

  def guess(letter)
    if @word.include?(letter)
      if @guesses.include?(letter)
        system('clear')
        puts "You already guessed #{letter}."
        sleep(1)
      else
      @guesses << letter
      system('clear')
      puts "Correct! The word includes #{letter}."
      sleep(1)
      end
    else
      if @wrong_guesses.include?(letter)
        system('clear')
        puts "You already guessed #{letter}."
        sleep(1)
      else
        @wrong_guesses << letter
        system('clear')
        puts "Wrong! The word doesn't include #{letter}."
        sleep(1)
      end
    end
  end

  def word_with_guesses
    if @guesses.empty?
      @word.gsub(/./, '_')
    else
      escaped_guesses = @guesses.map { |guess| Regexp.escape(guess) }.join
      @word.gsub(/[^#{escaped_guesses}]/, '_')
    end
  end

  def draw_hangman(wrong_guesses)
    case wrong_guesses.length
    when 0
      puts "  +---+"
      puts "      |"
      puts "      |"
      puts "      |"
      puts "      |"
      puts "      |"
      puts "========="
    when 1
      puts "  +---+"
      puts "  |   |"
      puts "      |"
      puts "      |"
      puts "      |"
      puts "      |"
      puts "========="
    when 2
      puts "  +---+"
      puts "  |   |"
      puts "  O   |"
      puts "      |"
      puts "      |"
      puts "      |"
      puts "========="
    when 3
      puts "  +---+"
      puts "  |   |"
      puts "  O   |"
      puts "  |   |"
      puts "      |"
      puts "      |"
      puts "========="
    when 4
      puts "  +---+"
      puts "  |   |"
      puts "  O   |"
      puts " /|   |"
      puts "      |"
      puts "      |"
      puts "========="
    when 5
      puts "  +---+"
      puts "  |   |"
      puts "  O   |"
      puts " /|\\  |"
      puts "      |"
      puts "      |"
      puts "========="
    when 6
      puts "  +---+"
      puts "  |   |"
      puts "  O   |"
      puts " /|\\  |"
      puts " /    |"
      puts "      |"
      puts "========="
    when 7
      puts "  +---+"
      puts "  |   |"
      puts "  O   |"
      puts " /|\\  |"
      puts " / \\  |"
      puts "      |"
      puts "========="
    when 8
      puts "  +---+"
      puts "  |   |"
      puts "  O   |"
      puts " /|\\  |"
      puts " / \\  |"
      puts " K.   |"
      puts "========="
    when 9
      puts "  +---+"
      puts "  |   |"
      puts "  O   |"
      puts " /|\\  |"
      puts " / \\  |"
      puts " K.O. |"
      puts "========="

  end
end

  def play
    system('clear')
    masked_word = @word.gsub(/./, '_').split('').join(' ')
    puts "Welcome to Hangman!"
    puts "You have 10 guesses to guess the word."
    puts "The word has #{@word.length} letters."
    puts "Good luck!"
    puts "Guess a letter:"
    while @wrong_guesses.length < 9 && masked_word.include?('_')
      draw_hangman(@wrong_guesses)
      puts "Wrong guesses: #{@wrong_guesses.join}"
      puts "Word: #{masked_word}"
      puts "Guess a letter:"
      letter = gets.chomp.downcase
      guess(letter)
      masked_word = word_with_guesses.split('').join(' ')
    end
    if masked_word.include?('_')
      puts "You lost! The word was #{@word.capitalize}."
    else
      puts "You won! The word was #{@word.capitalize}."
    end
  end
end

game = Game.new(words)
game.play
