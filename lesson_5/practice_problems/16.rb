require 'securerandom'

def uuid
  uuid = []
  
  len = 8
  uuid << SecureRandom.alphanumeric(len)
  
  3.times do
    len = 4
    uuid << SecureRandom.alphanumeric(len)
  end
  
  len = 12
  uuid << SecureRandom.alphanumeric(len)
  
  uuid.join('-')
end

p uuid