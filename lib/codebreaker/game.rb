module Codebreaker
  class Game
  	CODE_LENGTH = 4
  	ATTEMPT_COUNT = 10
  	HINT_COUNT = 1

  	attr_reader :attempts_made, :hints_made, :secret_code, :hint_str

  	def initialize
  	  @attempts_made = 0
  	  @hints_made = 0
  	end

  	def start
  	  @secret_code = CODE_LENGTH.times.map {Random.rand(1..6)}.join
  	  @hint_str = "*" * CODE_LENGTH
  	end

  	def guess(code)
  	  @attempts_made += 1	
  	  marked_guess = ""
  	  secret = @secret_code.dup

      code.each_char.with_index do |c, i|
        if secret[i] == c
          marked_guess += "+"
          secret[i] = "*"
          code[i] = "0"
        end
      end
      code.each_char.with_index do |c, i|
        if (secret[i] != c && secret.include?(c))
          marked_guess += "-"
          secret[i] = "*"
        end
      end
      marked_guess
    end

    def hint
      @hint_str[@hints_made] = @secret_code[@hints_made]
      @hints_made += 1
      @hint_str
    end
  end
end