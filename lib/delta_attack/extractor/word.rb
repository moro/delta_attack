require 'delta_attack/extractor/base'

include_class 'org.apache.poi.hwpf.HWPFDocument'

module DeltaAttack
  module Extractor
    class Word < Base

      private
      def extract_data
        input_stream = java_input_stream
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

