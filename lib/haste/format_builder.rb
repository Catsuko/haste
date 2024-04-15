require_relative 'progress'
require_relative 'formatted'

require_relative 'views/percent'
require_relative 'views/bar'
require_relative 'views/label'
require_relative 'views/spinner'
require_relative 'views/timed'

module Haste
  class FormatBuilder
    def initialize(views: [])
      @views = views
    end

    def progress(value=0, to:)
      Formatted.new(Progress.new(value, to: to), views: @views)
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

    def timed
      tap { @views << Views::Timed.new }
    end
  end
end
