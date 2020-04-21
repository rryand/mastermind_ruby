module ColorizeText
  COLORS = {
    "1" => "\e[44m 1 \e[0m",
    "2" => "\e[41m 2 \e[0m",
    "3" => "\e[43m 3 \e[0m",
    "4" => "\e[42m 4 \e[0m",
    "5" => "\e[45m 5 \e[0m",
    "6" => "\e[46m 6 \e[0m",
    "*" => "\e[104m \e[30m* \e[0m",
    "!" => "\e[104m \e[30m! \e[0m"
  }

  def colorize(string)
    COLORS[string]
  end
end