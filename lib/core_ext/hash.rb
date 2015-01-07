# Monkey-patching Hash
class Hash

  def to_open_struct
    out = OpenStruct.new self
    out.each_pair { |k, v| out[k] = object_to_open_struct v }
    out
  end


  private


  def object_to_open_struct object
    if object.is_a? Hash
      object.to_open_struct
    elsif object.is_a? Array
      array_to_open_struct object
    else
      object
    end
  end


  def array_to_open_struct array
    array.map { |element| object_to_open_struct element }
  end

end
