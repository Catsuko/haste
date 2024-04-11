module Haste
  module Views
    class Spinner
      def initialize(frames: %w(◐ ◓ ◑ ◒), speed: 0.25)
        raise ArgumentError, 'Icon must have at least 1 frame' if frames.empty?
        
        @frames = frames
        @speed = speed.clamp(0, 1)
        @frame_counter = 0
      end

      def print(_f)
        @frames[frame_counter.floor % @frames.size]
      end

      private

      def frame_counter
        @frame_counter += @speed
      end
    end
  end
end
