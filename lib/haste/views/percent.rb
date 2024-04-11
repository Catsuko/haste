module Haste
  module Views
    class Percent
      def initialize(format: '%d%%')
        @format = format
      end

      def print(f)
        sprintf(@format, f * 100)
      end
    end
  end
end
