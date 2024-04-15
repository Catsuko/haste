require_relative 'progress'
require_relative 'formatted'

module Haste
  class FormatBuilder
    def initialize(views: [])
      @views = views
    end

    def progress(value=0, to:)
      Formatted.new(Progress.new(value, to: to), views: @views)
    end

    Dir[File.join(__dir__, 'views', '*.rb')].each do |file|
      require file
      method_name = File.basename(file, '.rb')
      klass_name = method_name.split('_').map(&:capitalize).join
      
      define_method(method_name) do |*args, **options|
        tap { @views << Views.const_get(klass_name).new(*args, **options) }
      end
    end    
  end
end
