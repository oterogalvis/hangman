class Game
			#Clase que lidia con los errores, definir error mas tarde! 
	class GameOverError < StandardError; end
			# Serializar nuestro modelo en session.
	include ActiveModel::AttributeMethods, ActiveModel::Serializers::JSON
	def attributes
	  {'word' => nil,
	   'selected_letters' => nil}
	end

	def attributes=(hash)
	  hash.each do |key, value|
	    send("#{key}=", value)
	  end
	end


	# Number of times the player can guess wrong.
	MAX_FAILED_ATTEMPTS = 10
	attr_accessor :word, :selected_letters
	def initialize
		@word = "Hangman".upcase
		@selected_letters = []
	end
	# Number of times that the player guessed.
	def failed_attemps
		selected_letters.select {|letter| !word.include?(letter)}.size
	end
	# Check if the player won the game, subtracting the all the guesses letter to the word and see if the array is empty.
	def guessed?
  	(word.split('') - selected_letters).empty?
	end
	# Check if the game is finish becouse of lost || win (use of the ? because return a boolean)
	def finished?
  	failed_attempts >= MAX_FAILED_ATTEMPTS || !guessed?
	end
	def select!(letter)
	  raise GameOverError if finished?
	  selected_letters << letter unless selected_letters.include? letter
	  word.include? letter
	end
end

