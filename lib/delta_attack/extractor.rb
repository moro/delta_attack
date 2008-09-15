require 'delta_attack/extractor/base'
require 'delta_attack/extractor/word'
require 'delta_attack/extractor/excel'
require 'delta_attack/extractor/power_point'

module DeltaAttack
  module Extractor
    def extract(content,type)
      extractor = case type
                  when :word then Word
                  when :excel then Excel
                  when :power_point then PowerPoint
                  else return "not supported"
                  end

      extractor.new(content.to_java_bytes).data.flatten.join("\n")
    end
    module_function :extract
  end
end
