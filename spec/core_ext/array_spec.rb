require 'core_ext/array'

describe Array do
  describe '#group' do
    it 'returns elements grouped by whether of not they pass the given block' do
      array = [1, 1, 2, 3, 5, 8, 13, 21, 34]
      expected = array.group(&:odd?)
      actual = [
        { passing: true, values: [1, 1] },
        { passing: false, values: [2] },
        { passing: true, values: [3, 5] },
        { passing: false, values: [8] },
        { passing: true, values: [13, 21] },
        { passing: false, values: [34] }
      ]
      expect(expected).to eql actual
    end
  end
end
