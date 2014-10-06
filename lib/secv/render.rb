require 'colored'

require_relative 'word'

module Secv

  class Render

    def render_word(word)
      puts word.identify.underline
      puts render_pronounce word.pronounce

      puts indent '单词释义'.cyan.bold
      puts render_trans! word.trans
      puts ''

      puts indent '网络释义'.cyan.bold
      puts render_extra_trans word.extra_trans
      puts ''

      puts indent '常用词组'.cyan.bold
      puts render_word_groups! word.word_groups
      puts ''

      puts indent '其它'.cyan.bold
      puts render_additional word.additional
    end

    def render_eng!(str, colors, limit = nil)
      pattern_replace!(str, /(\w+)\W/, limit) { |mat|
        # return mat.send colors unless colors.respond_to? :each
        # colors.each { |color| mat.send color }
        # mat
        result = mat
        if colors.respond_to? :each
          colors.each { |color| result = result.send color }
        else
          result = result.send colors
        end
        result
      }
    end

    def pattern_replace!(str, regex, limit = nil, &blk)
      to_search = str
      while regex =~ to_search do
        # @TODO if $1 contain regex meta character, then need to escape it.
        str.sub! /#{$1}/, blk.call($1)
        break if limit and (limit -= 1) == 0
        to_search = $'
      end
      str
    end

    private
      def indent(str, col=2)
        format('%s%s', ' ' * col, str)
      end

      REGEX_PRONOUNCE = /\[([^\[\]]*)\]/
      def render_pronounce(pronounce)
        pattern_replace!(pronounce, REGEX_PRONOUNCE) { |mat| mat.send(:yellow) }
      end

      def render_trans!(trans)
        trans.map! do |tran|
          render_eng! tran, :cyan, 1
          format("%s* %s", ' ' * 4, tran)
        end
        trans * "\r\n"
      end

      def render_extra_trans(extra_trans)
        format("%s* %s", ' ' * 4, extra_trans * ' | ')
      end

      def render_word_groups!(word_groups)
        lop = word_groups.length < 5 ? word_groups.length : 5
        result = []
        lop.times do |index|
          render_eng! word_groups[index], :cyan
          result << format("%s* %s", ' ' * 4, word_groups[index])
        end
        result * "\r\n"
      end

      def render_additional(additional)
        format("%s* %s", ' ' * 4, render_eng!(additional, :white))
      end
  end
end