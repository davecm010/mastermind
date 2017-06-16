class Mastermind


  def initialize
    @user_guess = []
    @winning_combo = nil
    @color_options = "|red|green|yellow|blue|orange|purple|black|white|"
    @turn_count = 0
    @hints = nil
  end

  def new_game
    title_sequence
    color_array_display
    combo_randomizer
    12.times do
      @turn_count += 1
      get_answer
      display_answer
      end_round
      show_hints
      game_over?
      color_array_display
    end
  end

  def title_sequence
    puts ""
    puts "MASTERMIND"
    puts ""
    puts "|_?_|_?_|_?_|_?_|"
    puts ""
    puts "Enter in 4 of the following colors in any order:"
    puts ""
    puts @color_options
    puts ""
  end

  def color_array_display
    if @turn_count % 3 == 0 && @turn_count > 1
      puts @color_options
      puts ""
    end
  end

  def combo_randomizer
    color_choices = ['red', 'green', 'yellow', 'blue', 'orange', 'purple', 'black', 'white']
    @winning_combo = color_choices.sample(4)
  end

  def get_answer
    @user_guess = []
    for i in 1..4
      print "#{i}:"
      input = gets.chomp.downcase.strip
      @user_guess << input
    end
    puts ""
  end

  def display_answer
    display_board = "|_1_|_2_|_3_|_4_|"
    @user_guess.each_with_index do |input, i|
      display_board = display_board.gsub((i + 1).to_s, input[0..2])
    end
    puts display_board + " Round: #{@turn_count}"
    puts ""
  end

  def end_round
    @hints = []
    @user_guess.each_with_index do |color, i|
      if @winning_combo[i] == color
        @hints.unshift("[x]")
      elsif @winning_combo.include? color 
        @hints << "[o]"
      end
    end
  end
  
  def show_hints
    if @hints.empty?
      2.times do
        puts "[ ][ ]"
      end
    else
      i = 0 
      2.times do 
        for x in i..i+1
          print @hints[x]
        end
        i += 2
        puts""
      end
    end
    puts ''
  end
  
  def game_over?
    if @user_guess == @winning_combo
      puts "You figured out the secret code, you win!"
      exit
    elsif @turn_count >= 12
      puts "You have run out of guesses, GAME OVER..."
      exit
    end
  end 

end

mastermind = Mastermind.new
mastermind.new_game
