class ComputerPlayer
  attr_accessor :code, :exact_index_pairs

  def generate_code
    code = ""
    4.times do
      code += (Random.new.rand(6) + 1).to_s
    end
    @code = code
  end

  def guess_code
    @exact_index_pairs ||= Hash.new
    generate_code
    @exact_index_pairs.each_pair { |index, digit| @code[index] = digit }
  end
end