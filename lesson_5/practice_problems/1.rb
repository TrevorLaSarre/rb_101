arr = ['10', '11', '9', '7', '8']

p arr.sort { |b, a| a.to_i <=> b.to_i }
