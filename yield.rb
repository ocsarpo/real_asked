def hello
  puts "hello"
  yield
  puts "Welcome"
end

hello {  puts "Hi"  }
