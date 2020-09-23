module Enumerable
  def my_each
    return to_enum(:my_each) unless block_given?

    i = 0
    while i < to_a.length
      yield to_a[i]
      i += 1
    end
    self
  end

  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?

    i = 0
    while i < to_a.length
      yield to_a[i], i
      i += 1
    end
    self
  end

  def my_select
    return to_enum(:my_select) unless block_given?

    result = []
    to_a.my_each { |item| result << item if yield(item) }
    result
  end

  def my_all?(arg = nil)
    
    if block_given?
    to_a.my_each {|i| return false if yield(i) == false}
    return true
    elsif arg.nil?
    to_a.my_each{ |i| return false if i.nil? || i==false}
  
    elsif !arg.nil? && (arg.is_a? Class)
    to_a.my_each{|i| return false if i.class != arg && i.class.superclass !=arg}
    elsif !arg.nil? && (arg.is_a? Regexp)
    to_a.my_each{|i| return false unless i.match(arg)}
    else
    to_a.my_each{|i| return false if i != arg}
  end
  true
  end

  def my_any?(arg = nil)
    
    if block_given?
    to_a.my_each {|i| return true if yield(i) == true}
    return false
    elsif arg.nil?
    to_a.my_each{ |i| return true unless i.nil? || i==false}
  
    elsif !arg.nil? && (arg.is_a? Class)
    to_a.my_each{|i| return true if i.class == arg ||i.class.superclass == arg}
    elsif !arg.nil? && (arg.is_a? Regexp)
    to_a.my_each{|i| return true if i.match(arg)}
    else
    to_a.my_each{|i| return true if i = arg}
  end
  false
  end
end

  def my_none?
    return to_enum(:my_none?) unless block_given?

    i = 0
    ans = false
    to_a.length.times do
      ans = yield to_a[i]

      break if ans == true

      i += 1
    end
    !ans
  end

  def my_count(number = nil)
    count = 0
    if number.nil?
      count = to_a.length
    else

      my_each { |i| count += 1 if number == i }

      print count
    end
  end

  def my_map(proc = nil)
    result = []

    to_a.my_each { |item| result << item if proc.call(item) }
    result
  end

  def my_inject(number = nil, symbol = nil)
    # Symbol only
    if !number.nil? && symbol.nil? && number.is_a?(String) || number.is_a?(Symbol)
      array = to_a
      product = array[0]
      (array.length - 1).times do |i|
        product = array[i + 1].send(number[0], product)
      end
      product

    # block only
    elsif block_given?
      total = 1
      my_each do |i|
        total = yield(total, i)
      end
      total
    elsif !number.nil? && symbol.nil?
      array = to_a
      product = number
      array.length(-1).times do |i|
        product = array[i + 1].send(number[0], product)
      end
      product
    end
  end
end

# Multiply Method

def multiply_els(array)
  array.my_inject(:*) { |x, y| x * y }
end

# Tests

puts '--My Each'
[1, 2, 3, 4].my_each { |x| puts x }

puts 'My Each With Index'
[1, 2, 3, 4].my_each_with_index { |x, i| puts x.to_s + ':' + i.to_s if x != 3 }

puts 'My Select'
print([5, 6, 7, 8].my_select { |item| item != 6 })
puts
puts 'My All'
puts (%w[cat dog human].my_all?)

puts 'My Any'
puts (%w[cat dog human].my_any?)

puts 'My none'
puts (%w[cat dog human].my_none? { |word| word.length >= 6 })

puts 'My count'
puts([5, 3, 7, 4, 3, 7].my_count(3))

puts 'My map'

print([1, 2, 3, 8, 9, 7].my_map(proc { |item| item >= 4 }))

puts
puts 'Multiply_els'
print multiply_els([1, 5, 3])