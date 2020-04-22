module TextContent
  LINE = '-' * 50
  def instructions
    <<~HEREDOC

    #{LINE}
    #{"Welcome to mastermind!".center(50)}
    #{LINE}

    How to play:
    
    You play as the \e[4mcodebreaker\e[0m and you must guess
    the computer's randomly generated 4-length code.

    The code is composed of 6 numbers:

    #{colorize("1")}#{colorize("2")}#{colorize("3")}#{colorize("4")}#{colorize("5")}#{colorize("6")}

    HEREDOC
  end

  def section(title)
    text = title == :breaker ? "Code Breaker" : "Code Maker"
    "#{LINE}\n#{text.center(50)}\n#{LINE}"
  end

  def game_message(message)
    {
      guess: "Enter your guess: ",
      win: "#{LINE}\n#{"You win! You outsmarted the computer!".center(50)}\n#{LINE}",
      again: "Play again?(y/n) "
    }[message]
  end

  def game_error(error)
    {
      empty_guess: "Please enter your guess.",
      incorrect_length: "Your guess should be 4 digits long.",
      invalid_digit: "All digits should be between 1-6."
    }[error]
  end
end