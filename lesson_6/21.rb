# frozen_string_literal: false

WINNING_TOTAL = 21
DEALER_LIMIT = 17
WINNING_ROUNDS = 5

def initialize_deck
  deck = {}
  face_cards = %w[jack queen king]
  (2..10).each { |x| deck[x] = [x, x, x, x] }
  face_cards.each { |x| deck[x] = [10, 10, 10, 10] }
  deck['ace'] = [[1, 11], [1, 11], [1, 11], [1, 11]]
  deck
end

def update_deck(card, deck)
  deck[card].delete_at(0)
end

def initial_hand(deck)
  hand = []

  2.times do
    card = deck.keys.sample
    hand << card
    update_deck(card, deck)
  end
  hand
end

def hand_total(hand, deck)
  total = 0
  hand.each { |x| total += deck[x][0] unless x == 'ace' }
  hand.each { |x| total += ace_value(deck, total) if x == 'ace' }
  total
end

def ace_value(deck, total)
  return deck['ace'][0][0] if (total + 11) > WINNING_TOTAL

  deck['ace'][0][1]
end

def hit(hand, deck)
  loop do
    card = deck.keys.sample
    next if deck[card].empty?

    hand << card
    update_deck(card, deck)
    break
  end
end

def busted?(total)
  !!(total > WINNING_TOTAL)
end

def calculate_winner(player_total, dealer_total)
  return 'The dealer won!' if dealer_total > player_total
  return 'You won!'        if player_total > dealer_total

  "It's a draw!"
end

def display_winner(player_total, dealer_total)
  puts "Your total is #{player_total} and the dealer's total is #{dealer_total}."
  new_line
  puts calculate_winner(player_total, dealer_total)
end

def display_points(players_points, dealers_points)
  new_line
  puts "You've won #{players_points} #{plural_rounds(players_points)} and the dealer's won " \
  "#{dealers_points} #{plural_rounds(dealers_points)}."
end

def plural_rounds(points)
  return 'round' if points == 1

  'rounds'
end

def new_line
  puts "\n"
end

def game_winner(player, dealer)
  return 'You' if player > dealer

  'The dealer' if dealer
end

# Introduction
puts "*** Welcome to #{WINNING_TOTAL}. The first one to win #{WINNING_ROUNDS} rounds is the winner! ***"
new_line

# rubocop:disable Metrics/BlockLength
# New game
loop do
  players_points = 0
  dealers_points = 0

  # Main Game Loop
  loop do
    deck = initialize_deck
    dealer = initial_hand(deck)
    player = initial_hand(deck)
    player_total = hand_total(player, deck)
    dealer_total = hand_total(dealer, deck)

    puts "Dealer has: #{dealer[0]} and an unknown card"
    puts "You have: #{player[0]} and #{player[1]}, for a total of #{player_total}."
    new_line

    # Player's turn
    loop do
      break if busted?(player_total)

      puts 'Hit or stay?'
      answer = gets.chomp

      case answer.downcase
      when 'hit'
        system 'clear'
        hit(player, deck)
        player_total = hand_total(player, deck)
        puts "You got a #{player[-1]}, so your new total is #{player_total}"
        new_line
      when 'stay'
        system 'clear'
        break
      else
        puts "That's not a valid response"
      end
    end

    if busted?(player_total)
      puts 'You busted! The dealer won!'
      dealers_points += 1
    end

    # Dealer's turn
    unless busted?(player_total)
      puts "Dealer's turn..."
      new_line
      turns = 0

      loop do
        if dealer_total >= DEALER_LIMIT
          puts 'The dealer chose to stay!' if turns.zero?
          new_line
          break
        else
          hit(dealer, deck)
          puts "The dealer chose to hit, and drew a #{dealer[-1]}"
          turns += 1
          dealer_total = hand_total(dealer, deck)
        end
      end
    end

    if busted?(dealer_total)
      puts 'The dealer busted! You won!'
      players_points += 1
    end

    # Compare and display round winner if appropriate
    unless busted?(player_total) || busted?(dealer_total)
      display_winner(player_total, dealer_total)

      case calculate_winner(player_total, dealer_total)
      when 'The dealer won!'
        dealers_points += 1
      when 'You won!'
        players_points += 1
      end
    end

    display_points(players_points, dealers_points)

    break if players_points >= WINNING_ROUNDS || dealers_points >= WINNING_ROUNDS

    # Next Round?
    new_line
    puts 'Do you want to play the next round? (Y/N)'
    next_round = gets.chomp
    system 'clear'
    break unless next_round.downcase == 'y'
  end

  # Display game winner
  if players_points >= WINNING_ROUNDS || dealers_points >= WINNING_ROUNDS
    new_line
    puts "*** #{game_winner(players_points, dealers_points)} won the game! ***"
  end

  # Another Game?
  new_line
  puts 'Do you want to start a new game (Y/N)'
  another_game = gets.chomp
  system 'clear'
  break unless another_game.downcase == 'y'
end
# rubocop:enable Metrics/BlockLength

puts 'Thanks for playing 21!'
