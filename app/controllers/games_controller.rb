require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = []
      (0...10).each { @letters << ("A".."Z").to_a.sample }
   @letters
  end

  def word_comparison
    @attempt = params[:longest_word]
    @grid = params[:grid]
    letters = @grid.split('').sort
    user_word = @attempt.upcase.split('').sort
    count = 0
    user_word.each do |letter|
      if letters.include?(letter)
        count += 1
        letters.delete_at(letters.index(letter))
      end
    end
    count == user_word.length
  end

  def english_word
  @attempt = params[:longest_word]
  response = JSON.parse(open("https://wagon-dictionary.herokuapp.com/#{@attempt}").read)
  response["found"]
  end

  def score
    @attempt = params[:longest_word]
     @grid = params[:grid]

    if !word_comparison
      @result = 'Sorry not in the grid'
    elsif word_comparison && english_word

      @result = 'ok good job'

    else
      @result = "not an english word"

    end
  end
end
