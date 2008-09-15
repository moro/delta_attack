begin
  require 'mahoro'
rescue LoadError
  nil
end

module DeltaAttack
  class FiletypeAssumption
    CONTENT_TYPES = {
      "application/msword" => :word,
      "application/vnd.ms-excel" => :excel,
      "application/vnd.ms-powerpoint" => :power_point,
    }.freeze

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

    def content_type
      CONTENT_TYPES.index(filetype)
    end

    private
    def by_content_type
      CONTENT_TYPES[@content_type]
    end

    def by_extention
      case File.extname(@filename).downcase
      when ".doc" then :word
      when ".xls" then :excel
      when ".ppt" then :power_point
      end
    end
  end
end
