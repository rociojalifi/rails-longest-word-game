require 'json'
require 'open-uri'

class GamesController < ApplicationController

  def new
    @letters = Array.new(10) { ('A'..'Z').to_a[rand(26)] }
  end

  def run
    @grid = generate_grid(10).join
    @start_time = Time.now
  end

  def score
    @letters = params[:letters]
    @word = params[:word]
    @included = included?(@word, @letters)
    @english_word = english_word(@word)
    start_time = Time.new(params[:start_time])
    end_time = Time.now
    @result = compute_score(@word, end_time - start_time)
  end

  def compute_score(attempt, time_taken)
    (time_taken > 60.0) ? 0 : attempt.size * (1.0 - time_taken / 60.0)
  end



  def included?(word,letters)
    word.chars.all? { |letter| word.count(letter) <= letters.downcase.count(letter) }
  end

  # Api para las palabras en ingles?
  def english_word(word)
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end
end


