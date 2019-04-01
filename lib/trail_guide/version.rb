module TrailGuide
  module Version
    MAJOR = 0
    MINOR = 1
    PATCH = 29
    VERSION = "#{MAJOR}.#{MINOR}.#{PATCH}"

    class << self
      def inspect
        VERSION
      end
    end
  end
end
