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

  def my_all?
    to_a.my_each do |i|
      return false if yield(i) == false

      return true
    end
  end

  def my_any?
    return to_enum(:my_any?) unless block_given?

    i = 0
    ans = false
    to_a.length.times do
      ans = yield to_a[i]

      break if ans == true

      i += 1
    end
    ans
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
    if block_given?
    my_each { |i| count += 1 if yield i }
    elsif number.nil?
      count = to_a.length
    else
      to_a.my_each { |i| count += 1 if number == i }
    end
    count
  end

  def my_map(proc = nil)
    return to_enum(:my_map) if !block_given? && proc.nil?
    result = []
    to_a.my_each { |item| result << item if proc.call(item) } if proc
    to_a.my_each { |item| result << yield(item) }
    result
  end
  # rubocop:disable Metrics/CyclomaticComplexity
  # rubocop:disable Metrics/PerceivedComplexity

  def my_inject(number = nil, symbol = nil)
    if !number.nil? && symbol.nil? && number.is_a?(String) || number.is_a?(Symbol)
      symbol = number
      number = nil
    end

    (raise LocalJumpError if !block_given? && number.nil? && symbol.nil?)

    if block_given?
      total = number
      my_each do |i|
        total = !total ? i : yield(total, i)
      end
      total
    elsif !number.nil? && symbol.nil?
      to_a.my_each { |i| number = yield i }

    elsif !symbol.nil?

      to_a.my_each { |i| number = number.nil? ? i : number.send(symbol, i) }
      number
    end
  end

  # rubocop:enable Metrics/CyclomaticComplexity
  # rubocop:enable Metrics/PerceivedComplexity
end

# Multiply Method

def multiply_els(array)
  array.my_inject(:*) { |x, y| x * y }
end