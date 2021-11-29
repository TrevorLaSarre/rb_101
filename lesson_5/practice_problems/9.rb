arr = [['b', 'c', 'a'], [2, 1, 3], ['blue', 'black', 'green']]

sorted = arr.map do |sub_array|
  sub_array.sort do |a, b|
    b <=> a
  end
end

p sorted