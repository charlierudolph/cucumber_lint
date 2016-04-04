require 'core_ext/string'

RSpec.describe String do
  describe 'lowercase' do
    it 'is the same as downcase' do
      expect('ABC'.lowercase).to eql 'abc'
    end
  end

  describe 'uppercase' do
    it 'is the same as upcase' do
      expect('abc'.uppercase).to eql 'ABC'
    end
  end
end
