require 'ostruct'

# Monkey-patching Array
class Array

  def to_open_struct
    map(&:to_open_struct)
  end

end


# Monkey-patching BasicObject
class BasicObject

  def to_open_struct
    self
  end

end


# Monkey-patching Hash
class Hash

  def to_open_struct
    out = OpenStruct.new self

    out.each_pair do |k, v|
      out[k] = v.to_open_struct
    end

    out
  end

end
