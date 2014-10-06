require 'secv/version'
require 'secv/site'
require 'secv/render'

module Secv

  class Runner
    def initialize
      @site = YouDao.new
      @render = Render.new
    end

    def run
      word = @site.query 'good'
      @render.render_word word
    end
  end
end