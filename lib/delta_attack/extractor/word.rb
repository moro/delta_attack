require 'java'

include_class 'org.apache.poi.hwpf.HWPFDocument'

module DeltaAttack
  module Extractor
    class Word
      attr_accessor :bytes
      def initialize(bytes)
        @bytes = bytes
      end

      def data(ignore_cache=false)
        return @data if (!ignore_cache) && @data

        @data = extract_data
      end

      private
      def extract_data
        input_stream = Java::JavaIo::ByteArrayInputStream.new(@bytes)
        begin
          book = HWPFDocument.new(input_stream)
          range = book.range
          (0...range.num_paragraphs).map do |i|
            range.paragraph(i).text.strip
          end
        ensure
          input_stream.close
        end
      end
    end
  end
end

