module Secv

  class Word

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

    def to_s
      "identify=#{identify}"
    end


  end
end