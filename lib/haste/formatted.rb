require 'delegate'

module Haste
  class Formatted < SimpleDelegator
    def initialize(progress, views: [])
      super(progress)
      @views = views
    end

    def to_s
      return super if @views.empty?

      @views.map { |view| view.print(__getobj__) }.join(' ')
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
