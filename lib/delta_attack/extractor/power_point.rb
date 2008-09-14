require 'delta_attack/extractor/base'

include_class 'org.apache.poi.hslf.usermodel.SlideShow'

module DeltaAttack
  module Extractor
    class PowerPoint < Base
      private
      def extract_data
        input_stream = java_input_stream
        begin
          slide_show = SlideShow.new(input_stream)
          slide_show.slides.map do |slide|
            slide.text_runs.map{|tr| tr.text }
          end
        end
      end
    end
  end
end
