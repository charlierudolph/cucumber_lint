# Monkey-patching String
class String

  alias_method :uppercase, :upcase
  alias_method :lowercase, :downcase

end
