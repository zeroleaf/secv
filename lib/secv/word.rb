module Secv

  class Word

    SEPARATOR = '||'

    attr_reader :identify, :pronounce, :trans, :extra_trans,
                :additional, :word_groups, :synonyms

    def initialize(identify, pronounce, trans, extra_trans,
                   additional, word_groups, synonyms)
      @identify       = identify
      @pronounce      = pronounce
      @trans          = trans
      @extra_trans    = extra_trans
      @additional     = additional
      @word_groups    = word_groups
      @synonyms       = synonyms
      # @TODO
      # @rel_word     # 同根次
      # @discriminate # 词语辨析
    end

    def self.from_list(list)
      identify    = list[0]
      pronounce   = list[1]
      trans       = field_split_from list[2]
      extra_trans = field_split_from list[3]
      additional  = list[4]
      word_groups = field_split_from list[5]
      synonyms    = field_split_from list[6]
      Word.new identify, pronounce, trans, extra_trans,
               additional, word_groups, synonyms
    end

    private
      def self.field_split_from(ele)
        return nil unless ele
        ele.split SEPARATOR
      end

    def to_s
      "identify=#{identify}"
    end


  end
end