require 'sqlite3'

module Domain

  class Sqlite

    DFT_DB_NAME = 'secv.db'

    def initialize(cfg)
      path = File.expand_path(DFT_DB_NAME, cfg.path)
      if cfg.database_config
        path = cfg.database_config.fetch('path', path)
      end

      @db = SQLite3::Database::new path

      @db.execute <<-SQL
        CREATE TABLE IF NOT EXISTS words (
          identify TEXT PRIMARY KEY,
          pronounce TEXT,
          trans TEXT,
          extra_trans TEXT,
          additional TEXT,
          word_groups TEXT,
          synonyms TEXT
        );
      SQL

      @db.execute <<-SQL
        CREATE TABLE IF NOT EXISTS word_infos (
          identify TEXT PRIMARY KEY,
          frequency INTEGER,
          add_time INTEGER,
          is_del INTEGER
        );
      SQL

      @db.execute <<-SQL
        CREATE TABLE IF NOT EXISTS aliases (
          num INTEGER PRIMARY KEY AUTOINCREMENT,
          a_from TEXT NOT NULL,
          a_to TEXT NOT NULL,
          UNIQUE(a_from)
        );
      SQL
    end

    def db
      return @db if @db
      init_db
    end

    def execute(sql, bind_vars = [], *args, &block)
      db.execute(sql, bind_vars, *args, &block)
    end
  end
end