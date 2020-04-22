class ComputerPlayer
  attr_reader :code

  def generate_code
    code = []
    4.times do
      code << Random.new.rand(6) + 1
    end
    puts "DEBUG: computer code: #{code.join}"
    @code = code.join
  end
end