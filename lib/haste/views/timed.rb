module Haste
  module Views
    class Timed
      def initialize(format='(%ds remaining)', delay: 0.5)
        @format = format
        @delay = delay
        @start_time = nil
      end

      def print(progress)
        f = progress.to_f
        return clear if f == 1

        time = Time.now.to_i
        if ready_to_print?(time)
          print_estimated_remaining(f, time: time)
        else
          @start_time ||= time
          nil
        end
      end

      private

      def ready_to_print?(time)
        @start_time && @start_time < time - @delay
      end

      def clear
        @start_time = nil
      end

      def print_estimated_remaining(f, time:)
        rate = f / (time - @start_time)
        estimated_remaining = (1 - f) / rate
        sprintf(@format, estimated_remaining.ceil)
      end
    end
  end
end
