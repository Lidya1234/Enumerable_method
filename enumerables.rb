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





  def my_inject(number = nil, symbol = nil)
    if !number.nil? && symbol.nil? && number.is_a?(String) || number.is_a?(Symbol)
      symbol=number
      number=nil
    end
    total=0
    if !block_given? && number.nil? && symbol.nil?
      raise LocalJumpError.new
    elsif block_given? 
      total=to_a[0]
      total = number if !number.nil?
      to_a.my_each{|i| total = yield total, i}
       total
    elsif !symbol.nil? && number.nil?
      array = to_a
      product = 0
      to_a.my_each{|i| product=product + i}
       product
    elsif !number.nil? && symbol.nil?
      array = to_a
      product = number
      to_a.my_each {|i| product =yield i}
      product
        
    elsif !number.nil? && !symbol.nil?

    total = number
    my_each do |i|
    total = nil ? total : total.send(symbol, i)
    end
   total
    end

  end


end

# Multiply Method

def multiply_els(array)
  array.my_inject
end


print multiply_els([1, 5, 3])