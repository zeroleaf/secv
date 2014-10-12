require_relative 'domain'

class Word
  include Domain

  SEP = '||'

  attr_reader :identify, :pronounce, :trans, :extra_trans,
              :additional, :word_groups, :synonyms

  def initialize(identify, pronounce, trans, extra_trans,
                 additional, word_groups, synonyms)
    @identify       = identify      # string
    @pronounce      = pronounce     # string
    @trans          = trans         # array
    @extra_trans    = extra_trans   # array
    @additional     = additional    # string
    @word_groups    = word_groups   # array
    @synonyms       = synonyms      # array
    # @TODO
    # @rel_word     # 同根次
    # @discriminate # 词语辨析
  end

  class << self
    def table_name
      'words'
    end

    def find_by_identify(identify)
      word = nil
      Domain.execute(
          "SELECT * FROM #{self.table_name} where identify = ?", [identify]) do |row|
        word = self.from_db_ins row
      end
      word
    end

    def from_db_ins(list)
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

    def field_split_from(ele)
      return nil unless ele
      ele.split SEP
    end
  end

  def save
    Domain.execute("INSERT INTO #{self.class.table_name} VALUES (?, ?, ?, ?, ?, ?, ?)",
                       [@identify, @pronounce, @trans.join(SEP),
                        @extra_trans.join(SEP), @additional,
                        @word_groups.join(SEP), @synonyms.join(SEP)])
  end

  def to_s
    "identify=#{identify}"
  end
end