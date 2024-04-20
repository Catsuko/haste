module Haste
  module Views
    class Fraction
      def initialize(format: '%d/%d')
        @format = format
      end

      def print(progress)
        sprintf(@format, progress.value, progress.goal)
      end
    end
  end
end
