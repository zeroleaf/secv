require 'readline'

require 'secv/version'
require 'secv/site'
require 'secv/render'
require 'secv/db'

module Secv

  class Runner
    def initialize
      @site = YouDao.new
      @render = Render.new
      @db = Db.new
    end

    def run
      while input = Readline.readline('> ', true)
        input.strip!
        next unless input
        result = query_word input
        @render.render_word result
      end
      puts "\nBye!"
    end

    def query_word(input)
      result = @db.get_word input
      return result if result
      word = @site.query input
      @db.save_word word
      word
    end
  end
end