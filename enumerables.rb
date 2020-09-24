# rubocop: disable Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity
# rubocop:disable Metrics/ModuleLength
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
      to_a.my_each { |i| return false if yield(i) == false }

      return true
    elsif arg.nil?
      to_a.my_each { |i| return false if i.nil? || n == false }

    elsif !arg.nil? && (arg.is_a? Class)
      to_a.my_each { |i| return false unless [i.class, i.class.superclass].include?(arg) }
    elsif !arg.nil? && (arg.is_a? Regexp)
      to_a.my_each { |i| return false unless i.match(arg) }
    else
      to_a.my_each { |i| return false if i != arg }
    end
    true
  end

  def my_any?(arg = nil)
    if block_given?
      to_a.my_each { |i| return true if yield(i) == true }
      return false
    elsif arg.nil?

      to_a.my_each { |i| return true unless i.nil? || i == false }

    elsif !arg.nil? && (arg.is_a? Class)
      to_a.my_each { |i| return true if [i.class, i.class.superclass].include?(arg) }
    elsif !arg.nil? && (arg.is_a? Regexp)
      to_a.my_each { |i| return true if i.match(arg) }
    else
      to_a.my_each { |i| return true if i == arg }
    end
    false
  end

  def my_none?(arg = nil)
    if block_given?
      to_a.my_each { |i| return false if yield(i) == true }
      return true
    elsif arg.nil?
      to_a.my_each { |i| return false if i }

    elsif !arg.nil? && (arg.is_a? Class)
      to_a.my_each { |i| return false if [i.class, i.class.superclass].include?(arg) }

    elsif !arg.nil? && (arg.is_a? Regexp)
      to_a.my_each { |i| return false if i.match(arg) }
    else
      to_a.my_each { |i| return false if i == arg }
    end
    true
  end

  def my_count(arg = nil)
    count = 0
    if block_given?
      to_a.my_each { |i| count += 1 if yield i }
    elsif !arg.nil?
      to_a.my_each { |i| count += 1 if i == arg }
    else
      to_a.my_each { |i| count += 1 if i }
    end
    count
  end

  def my_map(proc = nil)
    return to_enum(:my_map) unless block_given? || !proc.nil?

    result = []

    if block_given?
      to_a.my_each { |item| result << yield(item) }
    else
      to_a.my_each { |item| result << item if proc.call(item) }

    end
    result
  end

  def my_inject(number = nil, symbol = nil)
    if !number.nil? && symbol.nil? && number.is_a?(String) || number.is_a?(Symbol)
      symbol = number
      number = nil
    end
    (raise LocalJumpError if !block_given? && number.nil? && symbol.nil?)
    if block_given?
      number = number.nil? ? to_a[0] : number
      to_a.my_each { |i| number = yield number, i }

    elsif !number.nil? && symbol.nil?
      to_a.my_each { |i| number = yield i }
    elsif !symbol.nil?
      to_a.my_each { |i| number = number.nil? ? i : number.send(symbol, i) }

    end
    number
  end
end
# rubocop:enable Metrics/CyclomaticComplexity
# rubocop:enable Metrics/PerceivedComplexity
# rubocop:enable Metrics/ModuleLength
# Multiply Method

def multiply_els(array)
  array.my_inject(:*) { |x, y| x * y }
end
