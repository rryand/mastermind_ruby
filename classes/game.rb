require_relative "../modules/text_content"
require_relative "../modules/colorize_text"
require_relative "human_player"
require_relative "computer_player"

class Game
  include TextContent
  include ColorizeText

  def play
    clear_screen
    @computer = ComputerPlayer.new
    @player = HumanPlayer.new
    show_menu
  end

  private

  def show_menu
    choice = nil
    clear_screen
    puts menu
    until ["1", "2", "3", "4"].include?(choice)
      print "\e[1A\e[KChoice: "
      choice = gets.chomp
    end
    choose_menu_choice(choice)
  end

  def show_instructions
    clear_screen
    puts instructions
    continue
  end

  def breaker
    clear_screen
    puts section(:breaker)
    puts game_message(:breaker)
    @computer.generate_code
    (1..12).each do |turn|
      puts "\e[4mTurn #{turn}\e[0m:"
      print game_message(:guess)
      print_guess(@player)
      print_clues(@computer.code, @player.code)
      if @player.code == @computer.code
        puts game_message(:human_win)
        break
      elsif turn == 12
        puts game_message(:ai_win)
      end
    end
    breaker if play_again?
    show_menu
  end

  def maker
    clear_screen
    puts section(:maker)
    puts game_message(:maker)
    print game_message(:code)
    @player.make_code until code_is_valid?(@player.code)
    (1..12).each do |turn|
      puts "\e[4mTurn #{turn}\e[0m:                     "
      print_guess(@computer, true)
      print_clues(@player.code, @computer.code, true)
      if @player.code == @computer.code
        puts game_message(:ai_win)
        break
      elsif turn == 12
        puts game_message(:human_win)
        break
      end
      continue
    end
    @player.code = nil
    @computer.exact_index_pairs = {}
    maker if play_again?
    show_menu
  end

  def print_guess(player, ai_player = false)
    player.code = nil
    player.guess_code until code_is_valid?(player.code)
    if ai_player
      print  "Computer's Guess: "
    else
      print "Guess: "
    end
    player.code.split("").each { |digit| print colorize(digit) }
  end

  def print_clues(code, guess, ai_player = false)
    print " Clues: "
    exact, right = exact_and_same_code(code, guess, ai_player)
    exact.times { print colorize("!") }
    right.times { print colorize("*") }
    puts "\n "
  end

  def exact_and_same_code(code, guess, ai_player = false)
    exact = 0
    right = 0
    guess_arr = guess.split("")
    code_arr = code.split("")
    (1..2).each do |x|
      code_arr.each_with_index do |code_digit, index|
        if code_digit == guess_arr[index] && x == 1
          exact += 1
          code_arr[index] = "a"
          guess_arr[index] = "b"
          @computer.exact_index_pairs[index] = code_digit if ai_player
        elsif guess_arr.include?(code_digit) && x == 2
          right += 1
          @computer.right_digits << code_digit if ai_player
        end
      end
    end
    [exact, right]
  end

  def play_again?
    choice = ""
    until choice == "y" || choice == "n"
      print game_message(:again)
      choice = gets.chomp.downcase
    end
    choice == "y" ? true : false
  end

  def code_is_valid?(code)
    if code.nil?
      false
    elsif code == ""
      puts game_error(:empty_guess)
      false
    elsif code.length != 4
      puts game_error(:incorrect_length)
      false
    elsif !code.split("").all? { |x| "123456".include?(x) }
      puts game_error(:invalid_digit)
      false
    else 
      true
    end
  end
end