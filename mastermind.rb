class Mastermind

  def initialize
    @user_guess = []
    @winning_combo = []
    @display_board = "|_1_|_2_|_3_|_4_|"
    @color_options = "|red|green|yellow|blue|orange|purple|black|white|"
    @turn_count = 0
  end

  def new_game
    title_sequence
    color_array_display
    combo_randomizer
    12.times do
      @turn_count += 1
      get_answer
      display_answer
      end_round_hint
      color_array_display
    end
  end

  def title_sequence
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
    if @turn_count % 3 == 0 && @turn_count >= 2
      puts @color_options
      puts ""
    end
  end

  def combo_randomizer
    color_choices = ['red', 'green', 'yellow', 'blue', 'orange', 'purple', 'black', 'white']
    @winning_combo = color_choices.sample(4)
  end

  def get_answer
    for i in 1..4
      print "#{i}:"
      input = gets.chomp.downcase
      @user_guess << [input, i]
    end
    puts ""
  end

  def display_answer
    @user_guess.each do |input, i|
      @display_board = @display_board.gsub(i.to_s, input[0..2])
    end
    puts @display_board
    puts ""
  end

  def end_round_hint
    2.times do
      puts "|_|_|"
    end
    puts ""
  end

end

mastermind = Mastermind.new
mastermind.new_game