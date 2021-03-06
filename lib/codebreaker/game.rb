require 'yaml'

module Codebreaker
  class Game
    CODE_LENGTH = 4
    ATTEMPT_COUNT = 10
    HINT_COUNT = 1
    INFO = "info.txt"

    attr_reader :attempts_made, :hints_made, :won

    def initialize
      @attempts_made = 0
      @hints_made = 0
      @hint_str = "*" * CODE_LENGTH
      @won = false
    end

    def start
      @secret_code = CODE_LENGTH.times.map {Random.rand(1..6)}.join
    end

    def submit_guess(code)
      if @attempts_made < ATTEMPT_COUNT
        @attempts_made += 1
        @won = true if code == @secret_code
        return "++++" if @won == true
        guess(code)
      end
    end

    def hint
      @hint_str[@hints_made] = @secret_code[@hints_made]
      @hints_made += 1
      @hint_str
    end

    def save(player)
      info = {player: player, won: @won, attempts: @attempts_made, hints: @hints_made}
      File.open(INFO, "a+") {|file| YAML.dump(info, file)}
    end

    private
    def guess(code)
      marked_code = ""
      secret = @secret_code.dup
      code_copy = code.dup

      code_copy.each_char.with_index do |c, i|
        if secret[i] == c
          marked_code += "+"
          secret[i] = "0"
          code_copy[i] = "*"
        end
      end
      code_copy.each_char.with_index do |c, i|
        if secret.include?(c)
          marked_code += "-"
          secret[secret.index(c)] = "0"
          code_copy[i] = "*"
        end
      end
      marked_code
    end
  end
end