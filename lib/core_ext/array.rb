# Monkey-patching Array
class Array

  def to_open_struct
    map(&:to_open_struct)
  end

end
