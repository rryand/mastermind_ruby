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
      puts "\e[4mTurn #{turn}\e[0m:\n "
      print_guess(player)
      print_clues(computer.code, player.guess)
      if player.guess == computer.code
        puts game_message(:win)
        break
      else
        player.guess = nil
      end
    end
    puts game_message(:again)
  end

  def print_guess(player)
    print game_message(:guess)
    player.guess_code until guess_is_valid? (player.guess)
    player.guess.split("").each { |digit| print colorize(digit) }
  end

  def print_clues(code, guess)
    print " Clues: "
    exact, same = exact_and_same_code(code, guess)
    exact.times { print colorize("!") }
    same.times { print colorize("*") }
    puts "\n"
  end

  def exact_and_same_code(code, guess)
    exact = 0
    same = 0
    code_arr = code.split("")
    (1..2).each do |x|
      code_arr.each_with_index do |code_digit, index|
        if code_digit == guess[index] && x == 1
          exact += 1
          code_arr[index] = "a"
          guess[index] = "b"
        elsif guess.include?(code_digit) && x == 2
          same += 1
        end
      end
    end
    [exact, same]
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