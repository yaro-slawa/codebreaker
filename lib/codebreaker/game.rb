module Codebreaker
  class Game
  	CODE_LENGTH = 4
  	ATTEMPT_COUNT = 10

  	attr_reader :attempt

  	def initialize
  	  @attempt = 0
  	end

  	def start
  	  @secret_code = CODE_LENGTH.times.map {Random.rand(1..6)}.join
  	end

  	def guess(code)
  	  @attempt += 1	
  	  marked_guess = ""
  	  secret = @secret_code

      code.each_char.with_index do |c, i|
        if secret[i] == c
          marked_guess += "+"
          secret.gsub!(c, "*")
        end
      end
      code.each_char.with_index do |c, i|
        if (secret[i] != c && secret.include?(c))
          marked_guess += "-"
          secret.gsub!(c, "*")
        end
      end
      marked_guess
    end
  end
end