module Haste
  class ViewRegistry
    def initialize(registry = {})
      @registry = registry
    end

    def add(name, handler: nil, &block)
      add_to_registry(name, handler: handler.nil? ? block : handler)
    end

    def define_view_methods(target)
      @registry.each do |name, handler|
        target.add_view_builder_method(name, handler: handler)
      end
    end

    private

    def prepare_handler(handler, name:)
      case handler
      when String
        puts "#{handler}"
        prepare_handler(const_get(handler), name: name)
      when Class
        raise "`#{handler}` is expected to implement #print but does not." unless handler.method_defined?(:print)

        handler
      when Proc
        handler_class_from_proc(handler)
      else
        raise ArgumentError, "Cannot register `#{name}`, invalid argument: #{handler}"
      end
    end

    def add_to_registry(name, handler:)
      @registry.store(name, prepare_handler(handler, name: name)) 
    end

    def handler_class_from_proc(block)
      Class.new do
        def self.set_block(block)
          tap { @block = block }
        end
        
        def print(progress)
          self.class.instance_variable_get(:@block).call(progress)
        end
      end.set_block(block)
    end
  end
end
