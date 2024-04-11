require 'delegate'
require_relative 'views/percent'
require_relative 'views/bar'
require_relative 'views/label'
require_relative 'views/spinner'

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

    def percent
      tap { @views << Views::Percent.new }
    end

    def bar
      tap { @views << Views::Bar.new }
    end

    def label(content)
      tap { @views << Views::Label.new(content) }
    end

    def spinner(options = {})
      tap { @views << Views::Spinner.new(**options) }
    end
  end
end
