def tricky_method_two(a_string_param, an_array_param)
  a_string_param << 'rutabaga'
  an_array_param = ['pumpkins', 'rutabaga']
end

my_string = "pumpkins"
my_array = ["pumpkins"]
tricky_method_two(my_string, my_array)

puts "My string looks like this now: #{my_string}"
puts "My array looks like this now: #{my_array}"

# my_string == "pumpkinstabaga" and my_array == ["pumpkins"] because assingment (+= in this case) dose not mutate the caller within a method, but 
# << does. The local variable an_array_param which exists only within the method now points to a new object of type array (["pumpkins", "rutabaga"])
# while the local variable a_string_param which exists only within the confines of the method points to the same object as my_string, which is then
# modified via a String#<< operation.