class HumanPlayer
  attr_accessor :code

  def guess_code
    @code = gets.chomp
  end

  def make_code
    code = ""
    code = gets.chomp
    @code = code
  end
end