module Haste
  module Views
    class Bar
      def initialize(length: 50, border: '|', fill: '█', empty: ' ')
        @length = length
        @border = border
        @fill = fill
        @empty = empty
      end

      def print(progress)
        chunk_size = 1.0 / @length
        chunks = @length.times.map { |i| progress.to_f > i * chunk_size ? @fill : @empty }
        "#{@border}#{chunks.join}#{@border}"
      end
    end
  end
end
