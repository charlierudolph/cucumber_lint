require 'core_ext/to_open_struct'

RSpec.describe Hash do
  describe 'to_open_struct' do
    it 'returns to an OpenStruct object' do
      hash = { a: 1 }
      struct = hash.to_open_struct
      expect(struct).to be_a OpenStruct
      expect(struct.a).to eql 1
    end

    it 'creates OpenStruct objects for nested hashes' do
      hash = { a: { b: 1 }, c: [{ d: 2 }] }
      struct = hash.to_open_struct
      expect(struct.a).to be_a OpenStruct
      expect(struct.a.b).to eql 1
      expect(struct.c[0]).to be_a OpenStruct
      expect(struct.c[0].d).to eql 2
    end
  end
end
