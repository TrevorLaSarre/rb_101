# Ask user for 2 numbers
# Ask user for operation to perform
# Perform the operation on the 2 numbers
# Output the result

require 'yaml'
MESSAGES = YAML.load_file('calculator_messages.yml')

LANGUAGE = 'en'

def prompt(message)
  puts "=> #{message}"
end

def valid_number?(num)
  num.to_i.to_s == num
end

def float?(num)
  num.to_f.to_s == num
end

def number?(num)
  float?(num) || valid_number?(num)
end

def operation_to_message(op)
  x = case op
      when "1"
        "Adding"
      when "2"
        "Subtracting"
      when "3"
        "Multiplying"
      when "4"
        "Dividing"
      end
x
end

prompt(MESSAGES[LANGUAGE]["welcome"])

name = ""
loop do
  name = gets.chomp

  if name.empty?
    prompt(MESSAGES[LANGUAGE]["valid_name_error"])
  else
    break
  end
end

prompt("Hi, #{name}!")

loop do # Main Loop
  number1 = ""
  loop do
    prompt(MESSAGES[LANGUAGE]["first"])
    number1 = gets.chomp

    if valid_number?(number1)
      break
    else
      prompt(MESSAGES[LANGUAGE]["valid_number_error"])
    end
  end

  number2 = ""
  loop do
    prompt(MESSAGES[LANGUAGE]["second"])
    number2 = gets.chomp

    if valid_number?(number2)
      break
    else
      prompt(MESSAGES[LANGUAGE]["valid_number_error"])
    end
  end

  operation_prompt = <<-MSG
  What operation would you like to perform? 
  1) Add
  2) Subtract
  3) Multiply
  4) Divide

  MSG

  prompt(operation_prompt)

  operation = ""
  loop do
    operation = gets.chomp

    if %w(1 2 3 4).include?(operation)
      break
    else
      prompt(MESSAGES[LANGUAGE]["operation_error"])
    end
  end

  prompt("#{operation_to_message(operation)} the two numbers...")

  result = case operation
           when "1"
             number1.to_i + number2.to_i
           when "2"
             number1.to_i - number2.to_i
           when "3"
             number1.to_i * number2.to_i
           when "4"
             number1.to_f / number2.to_f
           end

  prompt("The result is #{result}")

  prompt("Do you want to perform another calculation? (Y to calculate again)")
  answer = gets.chomp
  break unless answer.downcase.start_with?("y")
end

prompt(MESSAGES[LANGUAGE]["exit"])
