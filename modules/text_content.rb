module TextContent
  LINE = '-' * 50
  WELCOME_TEXT = "#{LINE}\n#{"Welcome to \e[1;5mMASTERMIND!\e[0m".center(60)}\n#{LINE}"

  def instructions
    <<~HEREDOC

    #{WELCOME_TEXT}

    \e[1;4mHow to play\e[0m:
    
    You play as the \e[4mcodebreaker\e[0m or the \e[4mcodemaker\e[0m and 
    you must guess the computer's randomly generated 
    code or make a code for the computer to solve.

    The code is composed of \e[4m4 digits\e[0m ranging between:

    #{" " * 16}#{colorize("1")}#{colorize("2")}#{colorize("3")}#{colorize("4")}#{colorize("5")}#{colorize("6")}

    After each guess, a maximum of \e[4mfour clues\e[0m will 
    be given.

    #{colorize("!")} means that you have one correct digit/color 
        in correct position.

    #{colorize("*")} means that you have one correct digit/color 
        out of position.

    HEREDOC
  end
  
  def menu
    <<~HEREDOC

    #{WELCOME_TEXT}

    Choose an option:
      [1] Codemaker
      [2] Codebreaker
      [3] How to play
      [4] Exit


    HEREDOC
  end

  def continue
    print "Press any key to continue..."
    gets
    print "\e[1A\r"
  end

  def clear_screen
    print `clear`
  end

  def section(title)
    text = title == :breaker ? "CODE_BREAKER" : "Code Maker"
    "#{LINE}\n#{text.center(50)}\n#{LINE}"
  end

  def game_message(message)
    {
      guess: "Enter your guess: ",
      win: "#{LINE}\n#{"You win! You outsmarted the computer!".center(50)}\n#{LINE}\n ",
      again: "\e[1A\e[KPlay again?(y/n) "
    }[message]
  end

  def game_error(error)
    print "ERROR: "
    {
      empty_guess: "Please enter your guess.",
      incorrect_length: "Your guess should be 4 digits long.",
      invalid_digit: "All digits should be between 1-6."
    }[error]
  end

  def choose_menu_choice(player, computer, choice)
    case choice
    when "1"
      breaker(player, computer)
    when "2"
      puts "UNDER CONSTRUCTION"
      continue
      show_menu(player, computer)
    when "3"
      show_instructions
      show_menu(player, computer)
    else
      return
    end
  end
end