require_relative 'haste/format_builder'

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

  def self.demo(limit: 50, delay: 0.1, &block)
    puts
    progress_bar = instance_eval(&block).build(goal: limit)
    limit.times { |n| progress_bar.update(n + 1).print; sleep(delay) }
    puts
  end
end
