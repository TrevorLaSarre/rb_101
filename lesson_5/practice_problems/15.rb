arr = [{a: [1, 2, 3]}, {b: [2, 4, 6], c: [3, 6], d: [4]}, {e: [8], f: [6, 10]}]

q = arr.select do |hash|
  hash.all? do|_, value|
    value.all? do |x|
      x.even?
    end
  end
end

p q