answer = 42

def mess_with_it(some_number)
  some_number += 8
end

new_answer = mess_with_it(answer)

p answer - 8

# This code prints 34 because the method does not mutate answer. In fact, integers are immutable in Ruby.