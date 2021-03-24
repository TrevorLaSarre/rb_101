def factors(number)
  divisor = number
  factors = []
  while number > 0
    factors << number / divisor if number % divisor == 0
    divisor -= 1
  end
  factors
end

# Bonus
# number % divisor == 0 determines whether or not number can be divided by divisor evenly

# Bonus 2
# Line 8 ensures that the method always return the value of factors