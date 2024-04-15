require_relative 'haste/progress'
require_relative 'haste/format_builder'
require_relative 'haste/formatted'

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
end
