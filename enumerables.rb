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

  def my_select1
    return to_enum(:my_select1) unless block_given?
   i=0
    to_a.length - 1.times do
      yield to_a[i]
      i+=1
    end
  end

  def my_select
    return to_enum(:my_select) unless block_given?

    new_arr = []
    my_each { |item| new_arr << item if yield(item) }
    new_arr
  end
end
[1, 2, 3, 4].my_each  do|x| 
    puts x 
end
[1, 2, 3, 4].my_each_with_index { |x, i| puts x.to_s + ':' + i.to_s if x != 3 }

result_a = []  
[1, 2, 3, 4].my_select1 do |x|
    result_a.push(x)
end
puts result_a