hsh = {
  'grape' => {type: 'fruit', colors: ['red', 'green'], size: 'small'},
  'carrot' => {type: 'vegetable', colors: ['orange'], size: 'medium'},
  'apple' => {type: 'fruit', colors: ['red', 'green'], size: 'medium'},
  'apricot' => {type: 'fruit', colors: ['orange'], size: 'medium'},
  'marrow' => {type: 'vegetable', colors: ['green'], size: 'large'},
}

hsh2 = hsh.map do |_, descriptions|
  if descriptions[:type] == 'fruit'
    descriptions[:colors].map { |x| x.upcase }
  elsif descriptions[:type] == 'vegetable'
    descriptions[:size].capitalize
  end
end

p hsh2