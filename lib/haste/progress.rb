module Haste
  class Progress
    attr_reader :value, :goal

    def initialize(goal:)
      raise ArgumentError, '`goal` cannot be zero' if goal.zero?

      @value = 0
      @goal = goal
    end

    def to_s
      to_f.to_s
    end

    def inspect
      "<Progress #{@value}/#{@goal}>"
    end

    def to_f
      (@value / @goal.to_f).clamp(0, 1.0)
    end

    def reset
      update(0)
    end

    def update(value)
      tap { @value = value }
    end

    def increase(value)
      update(@value + value)
    end
  end
end
