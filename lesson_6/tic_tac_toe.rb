# frozen_string_literal: false

INITIAL_MARKER = ' '.freeze
PLAYER_MARKER = 'X'.freeze
COMPUTER_MARKER = 'O'.freeze
WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] +
                [[1, 4, 7], [2, 5, 8], [3, 6, 9]] +
                [[3, 5, 7], [1, 5, 9]]
ROUNDS_PER_GAME = 5

def prompt(string)
  puts "=> #{string}"
end

def new_line
  puts "\n"
end

# rubocop:disable Metrics/MethodLength, Metrics/AbcSize
def display_board(brd, clear = true)
  system 'clear' if clear
  puts "You are #{PLAYER_MARKER}. Computer is #{COMPUTER_MARKER}." if clear
  puts ''
  puts '     |     |   '
  puts "  #{brd[1]}  |  #{brd[2]}  |  #{brd[3]}"
  puts '     |     |  '
  puts '-----+-----+-----'
  puts '     |     |   '
  puts "  #{brd[4]}  |  #{brd[5]}  |  #{brd[6]}"
  puts '     |     |  '
  puts '-----+-----+-----'
  puts '     |     |   '
  puts "  #{brd[7]}  |  #{brd[8]}  |  #{brd[9]}"
  puts '     |     |  '
  puts ''
end
# rubocop:enable Metrics/MethodLength, Metrics/AbcSize

def initialize_board
  new_board = {}
  (1..9).each { |x| new_board[x] = INITIAL_MARKER }
  new_board
end

def example_board
  new_board = {}
  (1..9).each { |x| new_board[x] = x }
  new_board
end

def empty_squares(brd)
  brd.keys.select { |num| brd[num] == INITIAL_MARKER }
end

# rubocop:disable Metrics/AbcSize
def joinor(arr, pun = ', ', word = 'or')
  result = ''
  arr.each_with_index do |obj, ind|
    result << obj.to_s if arr.length <= 1
    result << obj.to_s + pun if ind < (arr.length - 1)
    result << word + ' ' + obj.to_s if ind == (arr.length - 1) && ind.positive?
  end
  result
end
# rubocop:enable Metrics/AbcSize

def who_chooses
  loop do
    prompt 'Enter 1 to select who goes first, or 2 to allow the computer to choose'
    answer = gets.chomp
    return whos_first if answer == '1'
    return %w[1 2].sample if answer == '2'

    prompt "That's not a valid choice."
  end
end

def whos_first
  system 'clear'
  prompt 'Enter 1 to go first, or 2 to allow the computer to make the first move'
  answer = gets.chomp
  answer
end

def player_places_piece!(brd)
  square = ''
  loop do
    prompt "Choose a square (#{joinor(empty_squares(brd))}):"
    square = gets.chomp.to_i
    break if empty_squares(brd).include?(square)

    prompt "Sorry, that's not a valid choice."
  end

  brd[square] = PLAYER_MARKER
end

def defensive_comp_move(brd)
  WINNING_LINES.each do |line|
    next unless line.count { |x| brd[x] == PLAYER_MARKER } == 2 &&
                line.count { |x| brd[x] == INITIAL_MARKER } == 1

    square = line.select { |x| brd[x] == INITIAL_MARKER }.pop
    return brd[square] = COMPUTER_MARKER
  end
  nil
end

def offensive_comp_move(brd)
  WINNING_LINES.each do |line|
    next unless line.count { |x| brd[x] == COMPUTER_MARKER } == 2 &&
                line.count { |x| brd[x] == INITIAL_MARKER } == 1

    square = line.select { |x| brd[x] == INITIAL_MARKER }.pop
    return brd[square] = COMPUTER_MARKER
  end
  nil
end

def computer_places_piece!(brd)
  return if offensive_comp_move(brd)
  return if defensive_comp_move(brd)
  return brd[5] = COMPUTER_MARKER if brd[5] == INITIAL_MARKER

  square = empty_squares(brd).sample
  brd[square] = COMPUTER_MARKER
end

def board_full?(brd)
  empty_squares(brd).empty?
end

def someone_won?(brd)
  !!detect_winner(brd)
end

def detect_winner(brd)
  WINNING_LINES.each do |line|
    return 'Player' if line.all? { |square| brd[square] == PLAYER_MARKER }
    return 'Computer' if line.all? { |square| brd[square] == COMPUTER_MARKER }
  end
  nil
end

def game_over?(player_score, computer_score)
  !!(player_score >= ROUNDS_PER_GAME || computer_score >= ROUNDS_PER_GAME)
end

def display_game_winner(player_score, computer_score)
  new_line
  if player_score > computer_score
    prompt 'Congratulations -- you won the game!'
  else
    prompt "Look's like the computer won this game!"
  end
end

def place_piece!(board, current_player)
  if current_player == 'computer'
    computer_places_piece!(board)
  else
    player_places_piece!(board)
  end
end

def alternate_player(current_player)
  return current_player.gsub!('player', 'computer') if current_player == 'player'

  current_player.gsub!('computer', 'player')
end

# Introduction
prompt "Welcome to Tic Tac Toe! The first player to win #{ROUNDS_PER_GAME} rounds wins the game."
new_line
puts 'The board is numbered as follows:'
display_board(example_board, false)
# rubocop:disable Metrics/BlockLength
# Initialize a new game
loop do
  player_score = 0
  computer_score = 0
  current_player = 'computer'
  current_player = 'player' if who_chooses == '1'
  # Start a new round
  loop do
    board = initialize_board
    # Main gameplay
    loop do
      display_board(board)
      place_piece!(board, current_player)
      current_player = alternate_player(current_player)
      break if someone_won?(board) || board_full?(board)
    end

    display_board(board)
    # Detect winner and update scores
    if someone_won?(board)
      prompt "#{detect_winner(board)} wins!"
      player_score += 1 if detect_winner(board) == 'Player'
      computer_score += 1 if detect_winner(board) == 'Computer'
    else
      prompt "It's a tie!"
    end
    # Display Current Scores
    prompt "Your score is #{player_score}"
    prompt "The computer's score is #{computer_score}"
    # Detect and Display Game Winner
    if game_over?(player_score, computer_score)
      display_game_winner(player_score, computer_score)
      break
    end
    # Play another round?
    new_line
    prompt 'Play the next round? (Enter y for "yes")'
    answer = gets.chomp
    break unless answer.downcase.start_with? 'y'
  end
  # Start another game?
  break unless game_over?(player_score, computer_score)

  new_line
  prompt 'Would you like to play another game? (Enter y for "yes")'
  another_game = gets.chomp
  system 'clear'
  break unless another_game.downcase.start_with? 'y'
end
# rubocop:enable Metrics/BlockLength
system 'clear'
prompt 'Thanks for playing! Goodbye!'
