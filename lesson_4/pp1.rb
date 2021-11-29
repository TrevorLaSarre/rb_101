def titelize(string)
  new_string = ""
  counter = 1
  
  new_string << string[0].upcase unless string.size == 0
  
  loop do
    break if counter >= string.size
    
    if string[counter - 1] == " "
      new_string << string[counter].upcase
    else
      new_string << string[counter]
    end
    
    counter += 1
  end
  
  new_string
end

words = "ollie is the greatest cat and     this sentence  is weirdly SPACED"

p titelize(words)