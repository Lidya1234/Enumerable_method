require_relative '../enumerables.rb'

describe Enumerable do
  let(:num_array) { Array.new([1, 2, 3, 4, 5]) }
  let(:bool_array) { Array.new([true, true, true]) }
  let(:num_range) { (5..10) }
  let(:strings_array) { %w[cat sheep bear] }
  let(:mixed_array) { Array.new([nil, true, 99]) }

  describe '#my_each' do
    it 'if no block is given an enum is returned' do
      expect(num_array.my_each).to be_an Enumerator
    end
    it 'if no block is given an enum is returned' do
      expect(num_array.my_each).not_to eql(true)
    end

    it 'calls block with an argument for each item in enum' do
      expect(num_array.my_each { |i| i * 5 }).to eql(num_array)
    end
  end

  describe '#my_each_with_index' do
    it 'if no block is given an enum is returned' do
      expect(num_array.my_each_with_index).to be_an Enumerator
    end
    it 'if no block is given an enum is returned' do
      expect(num_array.my_each_with_index).not_to eql(true)
    end

    it 'calls block with two arguments, for each item and its index in enum' do
      expect(num_array.my_each_with_index { |item, _index| item * 4 }).to eql(num_array)
    end
  end

  describe '#my_select' do
    it 'if no block is given an enum is returned' do
      expect(num_array.my_each).to be_an Enumerator
    end
    it 'if no block is given an enum is returned' do
      expect(num_array.my_each).not_to eql(true)
    end

    it 'returns an array containing all items of enum, the block given returns a true value' do
      expect(num_array.select(&:even?)).not_to eql(num_array)
    end
  end

  describe '#my_all?' do
    it 'If block not given returns true when none of the collection members are false or nil.' do
      expect(bool_array.my_all?).to eql(true)
    end
    it 'If block not given returns true when none of the collection members are false or nil.' do
      expect(bool_array.my_all?).not_to eql(false)
    end

    it 'If a class is given it checks it if it gives same result as the .all enumerable.' do
      expect(num_array.my_all?(Integer)).to eql(num_array.all?(Integer))
    end
    it 'If a class is given it checks it if it gives same result as the .all enumerable.' do
      expect(num_array.my_all?(Numeric)).to eql(num_array.all?(Numeric))
    end
    it 'If a class is given it checks it if it gives same result as the .all enumerable.' do
      expect(strings_array.my_all?(String)).to eql(strings_array.all?(String))
    end
    it 'If a class is given it checks it if it gives same result as the .all enumerable.' do
      expect(strings_array.my_all?(/d/)).to eql(strings_array.all?(/d/))
    end
    it 'If a class is given it checks it if it gives same result as the .all enumerable.' do
      expect(strings_array.my_all?(/z/)).to eql(strings_array.all?(/z/))
    end
    it 'Passes each element of the collection to the given block, returns true if the block returns true' do
      expect(strings_array.my_all? { |word| word.length >= 4 }).not_to eql(true)
    end
  end

  describe '#my_any?' do
    it 'If block not given returns true if at least one of the collection members is not false or nil.' do
      expect(bool_array.my_any?).to eql(true)
    end
    it 'If block not given returns true if at least one of the collection members is not false or nil.' do
      expect(bool_array.my_any?).not_to eql(false)
    end

    it 'Passes each element of the collection to given block, returns true if the block ever returns a true value' do
      expect(mixed_array.my_any?(Integer)).to eql(true)
    end
    it 'If a class is given it checks it if it gives same result as the .any enumerable.' do
      expect(num_array.my_any?(Integer)).to eql(num_array.any?(Integer))
    end
    it 'If a class is given it checks it if it gives same result as the .any enumerable.' do
      expect(num_array.my_any?(Numeric)).to eql(num_array.any?(Numeric))
    end
    it 'If a class is given it checks it if it gives same result as the .any enumerable.' do
      expect(strings_array.my_any?(String)).to eql(strings_array.any?(String))
    end
    it 'If a class is given it checks it if it gives same result as the .any enumerable.' do
      expect(strings_array.my_any?(/d/)).to eql(strings_array.any?(/d/))
    end
    it 'If a class is given it checks it if it gives same result as the .any enumerable.' do
      expect(strings_array.my_any?(/z/)).to eql(strings_array.any?(/z/))
    end
  end

  describe '#my_none' do
    it 'If the block is not given, none? will return true only if none of the collection members is true.' do
      expect(bool_array.my_none?).to eql(false)
    end
    it 'If the block is not given, none? will return true only if none of the collection members is true.' do
      expect(bool_array.my_none?).not_to eql(true)
    end

    it 'Passes each element of collection to block, returns true if block returns otherwise for all elements.' do
      expect(strings_array.my_none? { |word| word.length == 2 }).not_to eql(false)
    end

    it 'If a pattern is supplied method returns whether pattern === element for none of the collection members.' do
      expect(mixed_array.my_none?(Float)).to eql(true)
    end
    it 'If a class is given it checks it if it gives same result as the .none enumerable.' do
      expect(num_array.my_none?(Integer)).to eql(num_array.none?(Integer))
    end
    it 'If a class is given it checks it if it gives same result as the .none enumerable.' do
      expect(num_array.my_none?(Numeric)).to eql(num_array.none?(Numeric))
    end
    it 'If a class is given it checks it if it gives same result as the .none enumerable.' do
      expect(strings_array.my_none?(String)).to eql(strings_array.none?(String))
    end
    it 'If a class is given it checks it if it gives same result as the .none enumerable.' do
      expect(strings_array.my_none?(/d/)).to eql(strings_array.none?(/d/))
    end
    it 'If a class is given it checks it if it gives same result as the .none enumerable.' do
      expect(strings_array.my_none?(/z/)).to eql(strings_array.none?(/z/))
    end
  end

  describe '#my_count' do
    it 'Returns the number of items in enum through enumeration.' do
      expect(bool_array.my_count).to eql(3)
    end
    it 'Returns the number of items in enum through enumeration.' do
      expect(bool_array.my_count).not_to eql(5)
    end

    it 'If an argument is given, the number of items in enum that are equal to item are counted.' do
      expect(num_array.my_count(2)).to eql(1)
    end

    it 'If a block is given, it counts the number of elements yielding a true value.' do
      expect(num_array.my_count(&:odd?)).to eql(3)
    end
  end

  describe '#my_map' do
    it 'If no block is given, an enumerator is returned instead.' do
      expect(num_array.my_map).to be_an Enumerator
    end
    it 'If no block is given, an enumerator is returned instead.' do
      expect(num_array.my_map).not_to eql(true)
    end

    it 'Returns a new array with the results of running block once for every element in enum.' do
      expect(num_array.my_map { |item| item * 4 }).not_to eql(num_array)
    end
  end

  describe '#my_inject' do
    it 'Combines all elements of enum specified by a block or a symbol that names a method or operator.' do
      expect(num_range.my_inject(:+)).to eql(45)
    end
    it 'Combines all elements of enum specified by a block or a symbol that names a method or operator.' do
      expect(num_array.my_inject(:+)).not_to eql(45)
    end

    it 'If block given, for each element in enum the block is passed an accumulator value (memo) and the element.' do
      expect(num_range.my_inject { |sum, n| sum + n }).to eql(45)
    end

    it 'If a symbol instead, each element in the collection will be passed to the named method of memo.' do
      expect(num_range.my_inject(1, :*)).to eql(151_200)
    end
    it 'If no initial value for memo, then the first element of collection is used as the initial value of memo.' do
      expect(strings_array.my_inject { |memo, word| memo.length > word.length ? memo : word }).to eql('sheep')
    end
  end

  describe 'multiply_els' do
    it 'Multiply all the elements inside an array and return the value' do
      expect(multiply_els(num_array)).to eql(120)
    end
  end
end
