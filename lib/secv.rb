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
        result = query_word input.strip
        @render.render_word result
      end
      puts "\nBye!"
    end

    def query_word(input)
      result = @db.get_word input
      return result if result
      @site.query input
    end
  end
end