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

    it 'calls block with an argument for each item in enum' do
      expect(num_array.my_each { |i| i * 5 }).to eql(num_array)
    end
  end


  describe '#my_each_with_index' do
    it 'if no block is given an enum is returned' do
      expect(num_array.my_each_with_index).to be_an Enumerator
    end

    it 'calls block with two arguments, for each item and its index in enum' do
      expect(num_array.my_each_with_index { |item, _index| item * 4 }).to eql(num_array)
    end
  end

  describe '#my_select' do
    it 'if no block is given an enum is returned' do
      expect(num_array.my_each).to be_an Enumerator
    end

    it 'returns an array containing all items of enum, the block given returns a true value' do
      expect(num_array.select(&:even?)).not_to eql(num_array)
    end
  end

  describe '#my_all?' do
    it 'If block not given returns true when none of the collection members are false or nil.' do
      expect(bool_array.my_all?).to eql(true)
    end

    it 'Passes each element of the collection to the given block. The method returns true if the block never returns false or nil' do
      expect(strings_array.my_all? { |word| word.length >= 4 }).not_to eql(true)
    end
  end

  describe '#my_any?' do
    it 'If block not given returns true if at least one of the collection members is not false or nil.' do
      expect(bool_array.my_any?).to eql(true)
    end

    it 'Passes each element of the collection to the given block. The method returns true if the block ever returns a value other than false or nil' do
      expect(mixed_array.my_any?(Integer)).to eql(true)
    end
  end


  describe '#my_none' do
    it 'If the block is not given, none? will return true only if none of the collection members is true.' do
      expect(bool_array.my_none?).to eql(false)
    end

    it 'Passes each element of the collection to the given block. The method returns true if the block never returns true for all elements.' do
      expect(strings_array.my_none? { |word| word.length == 2 }).not_to eql(false)
    end

    it 'If instead a pattern is supplied, the method returns whether pattern === element for none of the collection members.' do
      expect(mixed_array.my_none?(Float)).to eql(true)
    end
  end

  describe '#my_count' do
    it 'Returns the number of items in enum through enumeration.' do
      expect(bool_array.my_count).to eql(3)
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

    it 'Returns a new array with the results of running block once for every element in enum.' do
      expect(num_array.my_map { |item| item * 4 }).not_to eql(num_array)
    end
  end