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

    def self.from_db_ins(list)
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

    def as_db_ins
      @trans        = @trans * SEPARATOR
      @extra_trans  = @extra_trans * SEPARATOR
      @word_groups  = @word_groups * SEPARATOR
      @synonyms     = @synonyms * SEPARATOR
    end

    def dec_db_ins
      @trans = @trans.split SEPARATOR
      @extra_trans = @extra_trans.split SEPARATOR
      @word_groups = @word_groups.split SEPARATOR
      @synonyms =@synonyms.split SEPARATOR
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