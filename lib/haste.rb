require_relative 'haste/format_builder'
require_relative 'haste/view_registry'

module Haste
  def self.method_missing(method_name, *args, **kwargs, &block)
    builder = FormatBuilder.new

    if builder.respond_to?(method_name)
      builder.send(method_name, *args, **kwargs, &block)
    else
      super
    end
  end

  def self.respond_to_missing?(method_name, include_private)
    FormatBuilder.new.respond_to_missing?(method_name, include_private)
  end

  def self.add_views
    registry = ViewRegistry.new
    yield(registry)
    registry.define_view_methods(FormatBuilder)
  end

  def self.demo(limit: 50, delay: 0.1, &block)
    puts
    progress_bar = instance_eval(&block).build(goal: limit)
    limit.times { |n| progress_bar.update(n + 1).print; sleep(delay) }
    puts
  end
end

Haste.add_views do |registry|
  Dir[File.join(__dir__, 'haste', 'views', '*.rb')].each do |file|
    require file
    method_name = File.basename(file, '.rb')
    klass_name = method_name.split('_').map(&:capitalize).join
    registry.add(method_name, handler: Haste.const_get("Views::#{klass_name}"))
  end
end
