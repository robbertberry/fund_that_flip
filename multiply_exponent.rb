def multiply_recursive(num1, num2)
  return 0 if num1 == 0 || num2 == 0

  if num1 < 0
    num1 = -num1
    num2 = -num2
  end

  return -multiply_recursive(num1, -num2) if num2 < 0

  num1 + multiply_recursive(num1, num2 - 1)
end

def power_recursive(base, exponent)
  return 1 if exponent == 0

  if exponent < 0
    return 1.0 / power_recursive(base, -exponent)
  end

  multiply_recursive(base, power_recursive(base, exponent - 1))
end

loop do
  puts "Choose a method to run:"
  puts "1. Multiply"
  puts "2. Power"
  puts "3. Exit"

  choice = gets.chomp

  case choice
  when "1"
    print "Enter the first number: "
    a = gets.chomp.to_i
    print "Enter the second number: "
    b = gets.chomp.to_i
    result = multiply_recursive(a, b)
    puts "Result: #{result}"
  when "2"
    print "Enter the base number: "
    base = gets.chomp.to_i
    print "Enter the exponent: "
    exponent = gets.chomp.to_i
    result = power_recursive(base, exponent)
    puts "Result: #{result}"
  when "3"
    puts "Exiting the program..."
    break
  else
    puts "Invalid choice! Please try again."
  end
end
