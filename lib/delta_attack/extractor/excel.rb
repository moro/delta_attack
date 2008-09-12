require 'java'

include_class 'org.apache.poi.hssf.usermodel.HSSFWorkbook'
include_class 'org.apache.poi.hssf.usermodel.HSSFCell'

require 'benchmark'
module DeltaAttack
  module Extractor
    class Excel
      attr_accessor :input_stream
      def initialize(input_stream)
        @input_stream = input_stream
      end

      def data(ignore_cache=false)
        return @data if (!ignore_cache) && @data

        @data = extract_data
      end

      private
      def extract_data
        @input_stream.reset

        book = HSSFWorkbook.new(@input_stream)
        (0...book.number_of_sheets).map{|i|
          extract_from_sheet(book.sheet_at(i))
        }
      end

      def extract_from_sheet(sheet)
        sheet.row_iterator.map do |row|
          row.iterator.map do |cell|
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
  end
end

