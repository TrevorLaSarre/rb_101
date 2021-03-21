VALID_CHOICES = ["rock", "paper", "scissors", "lizard", "Spock"]

WINNING_CHOICES = {
  "rock" => ["scissors", "lizard"],
  "paper" => ["rock", "Spock"],
  "scissors" => ["paper", "lizard"],
  "lizard" => ["Spock", "paper"],
  "Spock" => ["scissors", "rock"]
}

WINNING_ROUNDS = 5

# Methods
def prompt(message)
  puts "=> #{message}"
end

def win?(first, second)
  WINNING_CHOICES[first].include?(second)
end

def display_result(human, computer)
  if win?(human, computer)
    prompt("You win this round!")
  elsif win?(computer, human)
    prompt("Computer won this round!")
  else
    prompt("This round was a tie!")
  end
end

def grand_winner(x, y)
  if x == WINNING_ROUNDS
    "You are the GRAND WINNER!"
  elsif y == WINNING_ROUNDS
    "Computer is the GRAND WINNER!"
  end
end

def clear_screen
  system('clear') || system('cls')
end

# Initialize scores
human_score = 0
computer_score = 0

# Intro
prompt("Let's play a game of Rock, Paper, Scissors, Spock, Lizard!")
prompt("First one to 5 wins is the GRAND WINNER!")
puts "\n"

# Main Loop
loop do
  choice = ""
  loop do
    prompt("Choose one: (r)ock, (p)aper, (s)cissors, (l)izard, (S)pock")
    choice = gets.chomp
    puts "\n"

    if VALID_CHOICES.include?(choice)
      break
    elsif ["r", "p", "s", "l", "S"].include?(choice)
      choice = "rock" if choice == "r"
      choice = "paper" if choice == "p"
      choice = "scissors" if choice == "s"
      choice = "lizard" if choice == "l"
      choice = "Spock" if choice == "S"
      break
    else
      prompt("That's not a valid choice.")
    end
  end

  computer_choice = VALID_CHOICES.sample

  prompt("You chose: #{choice}; Computer chose: #{computer_choice}")

  display_result(choice, computer_choice)

  # Tabulate Score
  if win?(choice, computer_choice)
    human_score += 1
  elsif win?(computer_choice, choice)
    computer_score += 1
  end

  prompt("Your score is: #{human_score}")
  prompt("The computer's score is: #{computer_score}")
  puts "\n"

  if !grand_winner(human_score, computer_score).nil?
    prompt(grand_winner(human_score, computer_score))
    break
  end

  # Repeat?
  prompt("Do you want to play again? (y/n)")
  answer = gets.chomp
  clear_screen
  break unless answer.downcase.start_with?("y")
end

prompt("Thank you for playing. Goodbye!")
