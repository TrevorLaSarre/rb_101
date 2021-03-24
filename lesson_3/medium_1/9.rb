def foo(param = "no")
  "yes"
end

def bar(param = "no")
  param == "no" ? "yes" : "no"
end

bar(foo)

# This code will output "no" because the foo method always outputs "yes", and "yes" passed into bar evaluates to "no"