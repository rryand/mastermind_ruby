require_relative "../modules/text_content"
require_relative "../modules/colorize_text"

class HumanPlayer
  include TextContent
  include ColorizeText
  attr_accessor :guess

  def guess_code
    print game_message(:guess)
    @guess = gets.chomp
    print  "Guess: "
    @guess.split("").each { |digit| print colorize(digit) }
    print " | "
  end
end