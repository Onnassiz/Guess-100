require 'colorize'

# Display basic message with color
class InputOutput
  def self.intro
    puts "\n\nWelcome to guess 100"
    puts "\nDo you want to know if you are good guessing?"
    puts "\nType 'S' to Start a new game or 'Q' to Quit"
  end

  def self.exit_game
    puts "\n"
    puts 'Good Bye'.cyan
    exit
  end

  def self.choose_option
    print 'Enter "S" to start a new game or "Q" to exit: '.cyan
    choice = gets
    choice = choice.strip
    exit_game if choice != ('S' || 's')
    choice
  end

  def self.show_message(message, type = 'default')
    case type
    when 'error'
      puts message.to_s.red
    when 'success'
      puts message.to_s.green
    else
      puts message.to_s
    end
  end

  def self.read_number
    number = 0
    until number > 0
      show_message('Please enter a number between 1 and 100:')
      number = gets.to_i
      show_message('You must enter a number greater than 0', 'error') if number < 1
    end
    number
  end
end

# a game instance
class Game
  attr_reader :number
  def initialize
    @number = rand(1...100)
    @attempts = 6
    @guess = nil
    start
  end

  def show_rules
    InputOutput.show_message('I have a secret number between 1 and 100 in my head. Can you tell me what that number is in 6 attempts?'.cyan)
  end

  def start
    show_rules
    @attempts.times do |i|
      InputOutput.show_message("\nYou have #{@attempts - i} #{get_attempts(@attempts - i)} left\n\n")
      number = InputOutput.read_number
      number == @number ? show_success(i + 1) : show_error(number, i + 1)
      break if number == @number
    end
  end

  def show_error(number, step)
    InputOutput.show_message("\nNo quite correct. The secret number is #{number > @number ? 'less' : 'greater'} than #{number}", 'error')
    InputOutput.show_message("\n---------You have lost the game. The secret number is #{@number}. Try again.---------\n", 'error') if step == @attempts
  end

  def show_success(attempt)
    InputOutput.show_message("\nCorrect!!! The secret number is #{@number}. You won after #{attempt} #{get_attempts(attempt)}\n", 'success')
  end

  def get_attempts(attempt)
    attempt == 1 ? 'attempt' : 'attempts'
  end
end

# Start and Stop a game instance
class InstantiateGame
  def initialize
    InputOutput.intro
    @choice = InputOutput.choose_option
    puts @choice.length
    until @choice != ('S' || 's')
      puts `clear`
      Game.new
      @choice = InputOutput.choose_option
    end
  end
end

InstantiateGame.new
