require_relative "user.rb"
require_relative "auth.rb"

class CLI

  def run 
    User.seed
    system("clear")
    greet
    enter_credentials
    sign_in
    while menu != "exit"
    end
    end_program
  end

  def greet
    puts "Welcome to the Authentication CLI!"
  end

  def end_program
    puts "Thank you for using the USA Covid 19 Tracker!"
  end

  def enter_credentials
    puts "Do you have an account? (y/n)"
    has_account = gets.chomp.downcase == "y"

    if has_account
      sign_in
    else
      sign_up
    end
  end

  def sign_in
    is_authenticated = false

    puts "Sign In\n\n"

    until is_authenticated
      puts "Please enter your username:"
      username = gets.chomp

      puts "Please enter your password:"
      password = gets.chomp

      is_authenticated = Auth.authenticate_user(username, password, User.all)
    end

      if is_authenticated
        @curr_user = is_authenticated
        puts "Welcome #{@curr_user.username}!"
      else
        puts "Invalid credentials. Please try again."
      end
    end
  end

  def sign_up
    puts "Sign Up\n\n"
    puts "Please enter your username:"
    username = gets.chomp
    puts "Please enter your password:"
    password = gets.chomp

    if username =="" || password == ""
      puts "Invalid credentials. Please try again."

      sign_up
      return nil
    end

    User.new(username, password)
    puts "Welcome #{username}! Please sign in to continue"
    sign_in
  end

  def menu
    list_options
    input = gets.chomp
    choos_option(input)
    input
  end

  def list_options
    puts "What would you like to do?"
    puts "1. View all users"
    puts "2. View all student users"
    puts "3. Exit the program by enter 'exit'"
  end

  def choos_option(input)
    case input
      when "1"
        puts "Lising all users"
      when "2"
        puts "Listing all student users"
    end
  end
  