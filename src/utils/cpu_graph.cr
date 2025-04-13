module BCrytop::Utils
  # Generate a graph to represent the CPU usage.
  def self.generate_cpu_graph(percentages_array : Array(Number)) : String
    output = String::Builder.new("")

    percentages_array.each_cons_pair do |current_percentage, next_percentage|
      current_percentage_level = (current_percentage * 4) // 100
      next_percentage_level = (next_percentage * 4) // 100

      output << print_braille_graph(current_percentage_level, next_percentage_level)
    end

    output.to_s
  end

  def self.print_braille_graph(first_number, second_number)
    case {first_number, second_number}
    # from 1 to n
    when {1, 1} then '\u28C0'
    when {1, 2} then '\u28E0'
    when {1, 3} then '\u28F0'
    when {1, 4} then '\u28F8'
    # from 2 to n
    when {2, 1} then '\u28C4'
    when {2, 2} then '\u28E4'
    when {2, 3} then '\u28F4'
    when {2, 4} then '\u28FC'
    # from 3 to n
    when {3, 1} then '\u28C6'
    when {3, 2} then '\u28E6'
    when {3, 3} then '\u28F6'
    when {3, 4} then '\u28FE'
    # from 4 to n
    when {4, 1} then '\u28C7'
    when {4, 2} then '\u28E7'
    when {4, 3} then '\u28F7'
    when {4, 4} then '\u28FF'
    end
  end
end
