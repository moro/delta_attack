
module DeltaAttack
  module Extractor
    class Base
      attr_accessor :bytes
      def initialize(bytes)
        @bytes = bytes
      end

      def data(ignore_cache=false)
        return @data if (!ignore_cache) && @data

        @data = extract_data
      end

      private
      def java_input_stream
        Java::JavaIo::ByteArrayInputStream.new(@bytes)
      end
    end
  end
end
