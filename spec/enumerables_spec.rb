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