module Haste
  module Views
    class Label
      def initialize(content)
        @content = content
      end

      def print(_f)
        @content
      end
    end
  end
end
