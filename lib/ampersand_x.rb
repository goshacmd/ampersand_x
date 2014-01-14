module AmpersandX
  VERSION = "0.0.1"

  class Proxy
    class << self
      def method_missing(name, *args)
        new([name, *args])
      end
    end

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
