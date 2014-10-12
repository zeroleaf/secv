require_relative 'sqlite'

module Domain

  class << self

    def init(cfg)
     self.database = initialize_database cfg
    end

    def execute(sql, bind_vars = [], *args, &block)
      database.execute(sql, bind_vars, *args, &block)
    end

    private

      def initialize_database(cfg)
        type = cfg.database_type
        case
          when type === 'mysql'
            # @TODO
          else
            Sqlite.new cfg
        end
      end

      attr_accessor :database
  end
end