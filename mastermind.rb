class Mastermind

  def initialize
    @user_guess = []
    @winning_combo = nil
    @color_array = "|red|green|yellow|blue|orange|purple|black|white|"
    @color_choices = ['red', 'green', 'yellow', 'blue', 'orange', 'purple', 'black', 'white']
    @turn_count = 0
    @hints = nil
    @game = nil
  end

  def new_game
    title_sequence
    if @game == '1'
      guessing_game
    elsif @game == '2'
      create_array
    end
  end

  private

  def title_sequence
    puts ""
    puts "MASTERMIND"
    puts ""
    puts "|_?_|_?_|_?_|_?_|"
    puts ""
    instructions
    game_type
  end

  def instructions
    puts "Instructions? (Y/N)"
    answer = gets.chomp.strip.downcase
    if answer == 'y'
      puts ""
      puts "Your objective is to guess the hidden sequence of 4 random colors."
      puts "Not only must you guess the correct 4 colors, but their order as well."
      puts "No single color is used more than once."
      puts "You have 12 rounds to guess the sequence."
      puts "At the end of each round, you will be given hints to help deduce the right sequence."
      puts "An [x] denotes you have correctly guessed one of the colors as well as its position in the sequence."
      puts "An [o] denotes you have correctly guessed one of the colors, but its order is incorrect"
      gets.chomp
    end
  end

  def game_type
    puts ""
    puts "Would you like to guess the computer's secret array,"
    puts "or challenge the computer with an array of your OWN?"
    puts "Type: '1' to GUESS hidden array | Type: '2' to CREATE an array"
    @game = gets.chomp.strip
  end

  def guessing_game #initializes option '1' where user guesses computer generated sequence
    puts "Enter in 4 of the following colors in any order:"
    puts ""
    puts @color_array
    puts ""
    combo_randomizer
    12.times do
      @turn_count += 1
      get_answer
      display_answer
      end_round
      show_hints
      user_game_over?
      color_array_display
    end
  end

  def create_array
    puts "Put 4 of the following colors in any sequence:"
    puts ""
    puts @color_array
    puts ""
    get_answer #uses get_answer to create winning_combo
    @winning_combo = @user_guess
    12.times do
      @turn_count += 1
      computer_guess
      display_answer
      end_round
      show_hints
      computer_game_over?
      sleep 2
    end
  end

  def color_array_display
    if @turn_count % 3 == 0 && @turn_count > 1
      puts @color_array
      puts ""
    end
  end

  def combo_randomizer
    @winning_combo = @color_choices.sample(4)
  end

  def computer_guess
    @user_guess = @color_choices.sample(4)
  end

  def get_answer
    @user_guess = []
    for i in 1..4
      print "#{i}:"
      input = gets.chomp.downcase.strip
      until @color_choices.include?(input) && !@user_guess.include?(input)
        if @user_guess.include? input
          puts "That color is already in use!"
        else
          puts "Must include a color from the array!"
        end
        print "#{i}:"
        input = gets.chomp.downcase.strip
      end
      @user_guess << input
    end
    @user_guess
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

  def user_game_over?
    if @user_guess == @winning_combo
      puts "You figured out the secret code, YOU WIN!"
      exit
    elsif @turn_count >= 12
      puts "You have run out of guesses, GAME OVER..."
      exit
    end
  end

  def computer_game_over?
    if @user_guess == @winning_combo
      puts "The computer figured out your secret code, GAME OVER..."
      exit
    elsif @turn_count >= 12
      puts "The computer ran out of guesses, YOU WIN!"
      exit
    end
  end

end

mastermind = Mastermind.new
mastermind.new_game
