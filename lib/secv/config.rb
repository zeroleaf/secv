require 'yaml'
require 'fileutils'

module Secv

  class Config
    include FileUtils

    DATABASE_TYPE_INDEX = 0
    DATABASE_CONFIG_INDEX = 1

    CONFIG_FILE_NAME = 'secv-conf.yml'

    class << self
      def config_path
        File.join File.dirname(__FILE__), '../../conf'
      end

      def default_config_file
        File.expand_path CONFIG_FILE_NAME, config_path
      end
    end

    def initialize(cus_path)
      @path = cus_path ? cus_path : File.expand_path('secv', ENV['HOME'])
      mkdir_p @path unless File.directory? @path

      cfg_file = File.expand_path(CONFIG_FILE_NAME, @path)
      cp self.class.default_config_file, @path unless File.exist? cfg_file

      @cfg = open(cfg_file, 'r') { |f| YAML.load f }
    end

    def path
      @path
    end

    def database_type
      @cfg['database'][DATABASE_TYPE_INDEX]
    end

    def database_config
      @cfg['database'][DATABASE_CONFIG_INDEX]
    end
  end
end