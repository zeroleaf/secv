require 'sqlite3'

module Sqlite

  def init_db
    @db = SQLite3::Database::new 'secv.db'

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
    @db
  end

  def db
    return @db if @db
    init_db
  end

  def execute(sql, bind_vars = [], *args, &block)
    db.execute(sql, bind_vars, *args, &block)
  end

end