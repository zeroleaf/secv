require 'open-uri'
require 'nokogiri'

require_relative 'word'

module Secv

  class Site

    def query(word)
      return nil if word == nil || word.empty?
      page = download(query_url word)
      extract_word(page)
    end

    def download(url)
      Nokogiri::HTML(open(URI::encode(url)))
    end

    protected

      # build query url of this word
      def query_url(word)
        raise 'query_url is a abstract method, subclass must implement it!'
      end

      # extract info from the web page, and return the word instance
      def extract_word(page)
        raise 'extract_word is a abstract method, subclass must implement it!'
      end

    private
      def next_element_sibling(element)
        sibling = element.next_sibling
        while sibling do
          return sibling if sibling.is_a? Nokogiri::XML::Element
          sibling = sibling.next_sibling
        end
        nil
      end

      def collect_text(es)
        es.collect { |e| text_with_gsub e }
      end

      def text_with_gsub(element, regex=/\s+/, replace=' ')
        return nil unless element
        element.text.strip.gsub regex, replace
      end
  end

  # YouDao Dict site
  class YouDao < Site

    protected

      def query_url(word)
        "http://dict.youdao.com/search?q=#{word}"
      end

      def extract_word(page)
        identify    = text_with_gsub  page.css('#phrsListTab h2 span.keyword')
        pronounce   = text_with_gsub  page.css('#phrsListTab div.baav')
        additional  = text_with_gsub  page.css('#phrsListTab div p.additional')
        trans       = collect_text    page.css('#phrsListTab div.trans-container li')
        extra_trans = collect_text    page.css('#webTransToggle div.title span')
        word_groups = collect_text    page.css('#wordGroup p.wordGroup')

        synonyms    = page.css('#synonyms li').collect do |synonym|
          sibling_text = text_with_gsub next_element_sibling synonym
          "#{synonym.text} #{sibling_text}"
        end

        Word.new(identify, pronounce, trans, extra_trans, additional, word_groups, synonyms)
      end
  end

end