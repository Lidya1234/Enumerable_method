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

  
end




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