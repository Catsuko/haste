module Haste
  class Progress
    attr_reader :value

    def initialize(value, limit:)
      raise ArgumentError, 'Progress limit cannot be zero' if limit.zero?
      
      @value = value
      @limit = limit
    end

    def to_s
      to_f.to_s
    end

    def inspect
      "<Progress #{@value}/#{@limit}>"
    end

    def to_f
      (@value / @limit.to_f).clamp(0, 1.0)
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
