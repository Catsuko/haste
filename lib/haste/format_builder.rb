require_relative 'progress'
require_relative 'formatted'

module Haste
  class FormatBuilder
    def initialize(views: [])
      @views = views
    end

    def build(goal:)
      Formatted.new(Progress.new(goal: goal), views: @views)
    end

    def self.add_view_builder_method(name, handler:)
      raise "`name` has already been defined, pick another name for the view" if respond_to?(name)

      define_method(name) do |*args, **options|
        tap { @views << handler.new(*args, **options) }
      end
    end
  end
end
