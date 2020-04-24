class ComputerPlayer
  attr_accessor :code, :exact_index_pairs, :right_digits

  def generate_code
    code = ""
    4.times do
      code += (Random.new.rand(6) + 1).to_s
    end
    @code = code
  end

  def guess_code
    @exact_index_pairs ||= {}
    @right_digits ||= []
    generate_code
    @exact_index_pairs.each_pair { |index, digit| @code[index] = digit }
    @right_digits.each do |digit|
      available_indexes = [0, 1, 2, 3].delete_if do |digit|
        @exact_index_pairs.keys.include?(digit)
      end
      index = Random.new.rand(available_indexes.length)
      @code[index] = digit
    end
    @right_digits.clear
  end
end