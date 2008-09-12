begin
  require 'mahoro'
rescue LoadError
  nil
end

module DeltaAttack
  class FiletypeAssumption
    def self.support_magic?
      defined? Mahoro
    end

    def initialize(filename, content_type = nil, content = nil)
      @filename = filename
      @content_type = content_type
      @content = content
    end

    def filetype
      by_content_type || by_extention || :unknown
    end

    private
    def by_content_type
      case @content_type
      when "application/vnd.ms-excel" then :excel
      end
    end
    def by_extention
      case File.extname(@filename).downcase
      when ".xls" then :excel
      end
    end
  end
end
