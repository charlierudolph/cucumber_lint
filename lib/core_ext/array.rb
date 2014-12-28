# Monkey-patching Array
class Array

  def group
    groups = []
    last_group = { passing: true, values: [] }

    each do |element|
      passing = yield element

      if passing != last_group[:passing]
        groups << last_group unless last_group[:values].empty?
        last_group = { passing: passing, values: [] }
      end

      last_group[:values] << element
    end

    groups + [last_group]
  end

end
