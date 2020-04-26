module GameDisplay
  def show_menu
    choice = nil
    clear_screen
    puts menu
    until ["1", "2", "3", "4"].include?(choice)
      print "\e[1A\e[KChoice: "
      choice = gets.chomp
    end
    choose_menu_choice(choice)
  end

  def choose_menu_choice(choice)
    case choice
    when "1"
      breaker
    when "2"
      maker
      show_menu
    when "3"
      show_instructions
      show_menu
    else
      return
    end
  end

  def show_instructions
    clear_screen
    puts instructions
    continue
  end
end