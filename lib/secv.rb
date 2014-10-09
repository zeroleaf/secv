require 'readline'

require 'secv/version'
require 'secv/site'
require 'secv/render'
require 'secv/db_logic'

module Secv

  class Runner
    def initialize
      @site = YouDao.new
      @render = Render.new
      @db_logic = DbLogic.new
    end

    def run
      while input = Readline.readline('> ', true)
        input.strip!
        next unless input
        result = query input
        @render.render_word result
      end
      puts "\nBye"
    end

    def query(input)
      result = @db_logic.get_als_word input
      return result if result
      word = @site.query input
      @db_logic.save_als_word input, word
      word
    end
  end
end