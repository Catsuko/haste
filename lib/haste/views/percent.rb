module Haste
  module Views
    class Percent
      def initialize(format: '%d%%')
        @format = format
      end

      def print(progress)
        sprintf(@format, progress.to_f * 100)
      end
    end
  end
end
