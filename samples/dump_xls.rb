#!/usr/bin/env ruby
# vim:set fileencoding=utf-8 filetype=ruby
$KCODE = 'u'

require 'java'
require 'benchmark'

include_class 'java.io.ByteArrayInputStream'
include_class 'org.apache.poi.hssf.usermodel.HSSFWorkbook'
include_class 'org.apache.poi.hssf.usermodel.HSSFCell'

content = File.open('samples/data/tc_01.xls', "rb"){|f| f.read }

puts Benchmark.realtime{
  ist = nil
  begin
    ist = ByteArrayInputStream.new(content.to_java_bytes)
    book = HSSFWorkbook.new(ist)
    sheet = book.sheet_at(0)
    values = sheet.row_iterator.map do |row|
      row.iterator.map do |cell|
        case cell.cell_type
        when HSSFCell::CELL_TYPE_NUMERIC 
          cell.numeric_cell_value.to_s
        when HSSFCell::CELL_TYPE_STRING 
          cell.rich_string_cell_value.string
        when HSSFCell::CELL_TYPE_BOOLEAN, HSSFCell::CELL_TYPE_BLANK 
          nil
        end
      end
    end
    values.each{|v| p v }
  ensure
    ist.close
  end
}

