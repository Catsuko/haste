require 'delegate'

module Haste
  class Formatted < SimpleDelegator
    def initialize(progress, views: [])
      super(progress)
      @views = views
    end

    def to_s
      return super if @views.empty?

      progress_float = to_f
      @views.map { |view| view.print(progress_float) }.join(' ')
    end

    def update(value)
      tap { super(value) }
    end

    def increase(value)
      tap { super(value) }
    end

    def print(to: STDOUT, padding: 100)
      to.print("\r#{self}".ljust(padding))
    end
  end
end
