require_relative "../modules/text_content"
require_relative "../modules/colorize_text"
require_relative "human_player"
require_relative "computer_player"

class Game
  include TextContent
  include ColorizeText

  def play
    hal = ComputerPlayer.new
    player = HumanPlayer.new
    puts instructions
    breaker(player, hal)
  end

  private

  def breaker(player, computer)
    puts section(:breaker)
    computer.generate_code
    (1..12).each do |turn|
      puts "\e[4mTurn #{turn}\e[0m:"
      player.guess_code until guess_is_valid? (player.guess)
      check_guess(computer.code, player.guess)
      if player.guess == computer.code
        puts game_message(:win)
        break
      else
        player.guess = nil
      end
    end
    puts game_message(:again)
  end

  def check_guess(code, guess)
    code_arr = code.split("")
    guess_arr = guess.split("")
    print "Clues: "
    guess_arr.each_with_index do |guess_digit, index1|
      code_arr.each_with_index do |code_digit, index2|
        if code_digit == guess_digit
          print index1 == index2 ? colorize("!") : colorize("*")
          break
        end
      end
    end
    puts "\n"
  end

  def guess_is_valid?(guess)
    if guess.nil?
      false
    elsif guess == ""
      puts game_error(:empty_guess)
      false
    elsif guess.length != 4
      puts game_error(:incorrect_length)
      false
    elsif !guess.split("").all? { |x| "123456".include?(x) }
      puts game_error(:invalid_digit)
      false
    else 
      true
    end
  end
end