class HumanPlayer
  attr_accessor :guess

  def guess_code
    @guess = gets.chomp
  end
end