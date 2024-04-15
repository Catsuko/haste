module Haste
  class Progress
    attr_reader :value

    def initialize(value, to:)
      raise ArgumentError, 'Progress to cannot be zero' if to.zero?
      
      @value = value
      @to = to
    end

    def to_s
      to_f.to_s
    end

    def inspect
      "<Progress #{@value}/#{@to}>"
    end

    def to_f
      (@value / @to.to_f).clamp(0, 1.0)
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
