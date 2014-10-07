require 'sqlite3'

module Secv

  class Db

    def initialize
      @db = SQLite3::Database::new 'secv.db'

      @db.execute <<-SQL
        CREATE TABLE IF NOT EXISTS words (
          identify varchar(45) PRIMARY KEY,
          pronounce varchar,
          trans varchar,
          extra_trans varchar,
          additional varchar,
          word_groups varchar,
          synonyms varchar
        );
      SQL
    end

    def save_word(word)
      @db.execute('INSERT INTO words VALUES (?, ?, ?, ?, ?, ?, ?)',
                  [word.identify, word.pronounce, word.trans, word.extra_trans,
                   word.additional, word.word_groups, word.synonyms])
    end

    # db.get_word 'good'    -> Word or nil
    #
    # Get word from db, return corresponding Word instance if word identify exist,
    # otherwise, return nil if not found.
    def get_word(identify)
      word = nil
      @db.execute('SELECT * FROM words where identify = ?', identify) do |row|
        word = Word.from_list row
      end
      word
    end
  end
end