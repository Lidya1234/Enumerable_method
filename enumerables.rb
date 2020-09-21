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
end
 [1, 2, 3, 4].my_each  do|x| 
     puts x 
end
[1, 2, 3, 4].my_each_with_index { |x, i| puts x.to_s + ':' + i.to_s if x != 3 }


print ([5, 6, 7, 8].my_select do|item|
  item!=6
end
)