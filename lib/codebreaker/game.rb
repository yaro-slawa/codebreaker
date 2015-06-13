module Codebreaker
  class Game
    CODE_LENGTH = 4
    ATTEMPT_COUNT = 10
    HINT_COUNT = 1

    attr_reader :attempts_made, :hints_made, :secret_code

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
      marked_code = ""
      secret = @secret_code.dup

      code.each_char.with_index do |c, i|
        if secret[i] == c
          marked_code += "+"
          secret[i] = "0"
          code[i] = "*"
        end
      end
      code.each_char.with_index do |c, i|
        if secret.include?(c)
          marked_code += "-"
          secret[secret.index(c)] = "0"
          code[i] = "*"
        end
      end
      marked_code
    end

    def hint
      @hint_str[@hints_made] = @secret_code[@hints_made]
      @hints_made += 1
      @hint_str
    end
  end
end