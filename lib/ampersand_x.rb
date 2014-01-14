module AmpersandX
  VERSION = "0.0.2"

  UNDEF = [:==]
  UNDEF_CLASS = UNDEF + [:>, :>=, :<, :<=]

  class Proxy
    class << self
      undef_method(*UNDEF_CLASS)

      def method_missing(name, *args)
        new([[name, *args]])
      end
    end

    undef_method(*UNDEF)

    # Initialize a +Proxy+.
    #
    # @param path [Array<Array>] path array
    def initialize(path = [])
      @path = path
    end

    def method_missing(*args)
      self.class.new(@path + [args])
    end

    # Get the actual value after calling all methods from +path+.
    #
    # @param x [Object] object to call path methods on
    def actual(x)
      @path.reduce(x) { |memo, prop| memo.send(*prop) }
    end

    # Convert proxy to a proc.
    def to_proc
      -> x { actual(x) }
    end
  end
end

X = AmpersandX::Proxy
