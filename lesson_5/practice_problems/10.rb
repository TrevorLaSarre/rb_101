arr = [{a: 1}, {b: 2, c: 3}, {d: 4, e: 5, f: 6}]

arr2 = arr.map do |hash|
  new_hash = {}
  hash.map do |key, value|
    new_hash[key] = value + 1
  end
  new_hash
end

p arr2