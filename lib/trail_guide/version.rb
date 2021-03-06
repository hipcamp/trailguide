module TrailGuide
  module Version
    MAJOR = 0
    MINOR = 2
    PATCH = 1
    VERSION = "#{MAJOR}.#{MINOR}.#{PATCH}"

    class << self
      def inspect
        VERSION
      end
    end
  end
end
