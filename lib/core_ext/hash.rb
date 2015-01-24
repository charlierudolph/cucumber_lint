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
