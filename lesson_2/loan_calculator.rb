# Methods
def valid_num(num)
  (num.to_f.to_s == num || num.to_i.to_s == num) && num.to_i >= 0
end

def extra_characters(num)
  if num.include? ","
    num.delete! ","
  elsif num.include? "%"
    num.delete! "%"
  end
end

def clear_screen
  system('clear') || system('cls')
end

def format_output(float)
  if float.nan?
    format('%.2f', 0)
  else
    format('%.2f', float)
  end
end

# Intro
puts "Hello! What is your name?"
name = gets.chomp
clear_screen
name = "friend" if name.empty?
intro = <<-MSG
Alright #{name}, let's calculate your monthly payments.

I just need a few pieces of information from you.

MSG
puts intro

# Main Loop
loop do
  loan_amount = ""
  loop do
    puts "First, what is your total loan amount?"
    print "$ "
    loan_amount = gets.chomp

    extra_characters(loan_amount)
    if valid_num(loan_amount)
      loan_amount = loan_amount.to_f
      break
    else
      puts "Please enter a valid, positive number."
    end
  end

  clear_screen

  apr = ""
  loop do
    puts "Next, what is the APR of the loan?"
    apr = gets.chomp

    extra_characters(apr)
    if valid_num(apr)
      apr = apr.to_f
      break
    else
      puts "Please enter a valid, positive number."
    end
  end

  clear_screen

  duration = ""
  loop do
    puts "Next, what is the duration of the loan (in months)?"
    duration = gets.chomp

    if valid_num(duration)
      duration = duration.to_f
      break
    else
      puts "Please enter a valid, positive number."
    end
  end

  clear_screen

  # Main Calculations
  monthly_rate = (apr / 12) * 0.01
  monthly_payment = loan_amount *
                    (monthly_rate / (1 - (1 + monthly_rate)**(-duration)))
  total_interest = (monthly_payment * duration) - loan_amount

  puts "Your monthly payment is $#{format_output(monthly_payment)}"
  puts "Over the course of the loan, "\
       "you'll pay $#{format_output(total_interest)} in interest."
  puts "\n"

  # Repeat?
  puts "Would you like to calculate the payments on another loan? (y/n)"
  repeat = gets.chomp.downcase
  while repeat != "y" && repeat != "n"
    puts "I'm sorry; I don't understand. Please press y or n"
    repeat = gets.chomp.downcase
  end
  if repeat == "y"
    clear_screen
    puts "Great!"
    puts "\n"
  elsif repeat == "n"
    clear_screen
    break
  end
end

puts "Thanks for using this loan calculator, #{name}. Have a great day!"
