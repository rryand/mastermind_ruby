require_relative "../modules/text_content"
require_relative "../modules/colorize_text"
require_relative "human_player"
require_relative "computer_player"

class Game
  include TextContent
  include ColorizeText

  def play
    clear_screen
    hal = ComputerPlayer.new
    player = HumanPlayer.new
    show_menu(player, hal)
  end

  private

  def show_menu(player, computer)
    choice = nil
    clear_screen
    puts menu
    until ["1", "2", "3", "4"].include?(choice)
      print "\e[1A\e[KChoice: "
      choice = gets.chomp
    end
    choose_menu_choice(player, computer, choice)
  end

  def show_instructions
    clear_screen
    puts instructions
    continue
  end

  def breaker(player, computer)
    clear_screen
    puts section(:breaker)
    computer.generate_code
    (1..12).each do |turn|
      puts "\e[4mTurn #{turn}\e[0m:"
      print_guess(player)
      print_clues(computer.code, player.guess)
      if player.guess == computer.code
        puts game_message(:win)
        break
      end
    end
    if play_again?
      breaker(player, computer) 
    else
      show_menu(player, computer)
    end
  end

  def print_guess(player)
    player.guess = nil
    print game_message(:guess)
    player.guess_code until guess_is_valid? (player.guess)
    print  "Guess: "
    player.guess.split("").each { |digit| print colorize(digit) }
  end

  def print_clues(code, guess)
    print " Clues: "
    exact, same = exact_and_same_code(code, guess)
    exact.times { print colorize("!") }
    same.times { print colorize("*") }
    puts "\n "
  end

  def exact_and_same_code(code, guess)
    exact = 0
    same = 0
    guess_arr = guess.split("")
    code_arr = code.split("")
    (1..2).each do |x|
      code_arr.each_with_index do |code_digit, index|
        if code_digit == guess_arr[index] && x == 1
          exact += 1
          code_arr[index] = "a"
          guess_arr[index] = "b"
        elsif guess_arr.include?(code_digit) && x == 2
          same += 1
        end
      end
    end
    [exact, same]
  end

  def play_again?
    choice = ""
    until choice == "y" || choice == "n"
      print game_message(:again)
      choice = gets.chomp.downcase
    end
    choice == "y" ? true : false
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