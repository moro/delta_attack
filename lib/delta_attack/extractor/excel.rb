require 'java'

include_class 'org.apache.poi.hssf.usermodel.HSSFWorkbook'
include_class 'org.apache.poi.hssf.usermodel.HSSFCell'

require 'benchmark'
module DeltaAttack
  module Extractor
    class Excel
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
          book = HSSFWorkbook.new(input_stream)
          return (0...book.number_of_sheets).map do |i|
            extract_sheet(book.sheet_at(i))
          end
        ensure
          input_stream.close
        end
      end

      def extract_sheet(sheet)
        sheet.iterator.map do |row|
          row.iterator.map{|cell| handle_cell(cell) }
        end
      end

      def handle_cell(cell)
        case cell.cell_type
        when HSSFCell::CELL_TYPE_NUMERIC
          cell.numeric_cell_value
        when HSSFCell::CELL_TYPE_STRING
          cell.rich_string_cell_value.string
        when HSSFCell::CELL_TYPE_BOOLEAN, HSSFCell::CELL_TYPE_BLANK
          nil
        end
      end
    end
  end
end

