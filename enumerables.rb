module Enumerable
  def my_each
    return to_enum(:my_each) unless block_given?

    i = 0
    while (i < to_a.length)
      yield to_a[i]
      i += 1
    end
    self
  end

  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?

    i = 0
    while (i < to_a.length)
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

  def my_all?
    to_a.my_each  do |i|
      
      if yield(i) == false
        return false
      else
        return true
    end
  end
  end

  def my_any?
    return to_enum(:my_any?) unless block_given?
    i=0
    ans = false
    (to_a.length).times do
     
      ans = yield to_a[i]
   
      if ans == true
        break
      end
      i+=1
    end
    return ans
  end

    def my_none?
    return to_enum(:my_none?) unless block_given?
    i=0
    ans = false
    (to_a.length).times do
     
      ans = yield to_a[i]
   
      if ans == true
        break
      end
      i+=1
    end
    return !ans
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
  
  def my_map
    return to_enum(:my_map) unless block_given?
    result =[]
    to_a.my_each {|item| result << item if yield item}
    result
end

def my_inject(number = nil, symbol=nil)
    
  
  # Symbol only
   if !number.nil? && symbol.nil? && number.is_a?(String) || number.is_a?(Symbol)
  array = to_a
    product = array[0]
    (array.length-1).times do |i|
    product = array[i + 1].send(number[0], product)
    end
    product
  

# block only
elsif block_given?
         total = 1
      self.my_each do |i|
        total = yield(total, i)
      end
      total
end
end
end
   
  


def multiply_els(array)
array.my_inject(:*) { |x , y| x * y}
end

print multiply_els([1,5,3])

 [1, 2, 3, 4].my_each  do|x| 
     puts x 
end
[1, 2, 3, 4].my_each_with_index { |x, i| puts x.to_s + ':' + i.to_s if x != 3 }


print ([5, 6, 7, 8].my_select do|item|
  item!=6
end
)

puts ["cat", "dog", "human"].my_all? { |word| word.length >= 4 }
puts ["cat", "dog", "human"].my_any? { |word| word.length >= 3 }
puts ["cat", "dog", "human"].my_none? { |word| word.length >= 6 }

puts ([5,3,7,4,3,7].my_count(3))

print ( [1,2,3,4,5,6,7].my_map do |item|
  item >=4
end
)
puts

puts ([1,5,5,4].my_inject do |x ,sum|
  sum=sum+x
  sum
end
)

puts ([1,2,5,4].my_inject(100) do |x ,sum|
  sum=sum+x
  sum
end
)











