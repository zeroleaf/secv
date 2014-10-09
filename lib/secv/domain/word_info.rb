require_relative 'sqlite'

class WordInfo
  extend Sqlite

  DEL_FALSE = 0
  DEL_TRUE  = 1

  def initialize(identify, frequency, add_time, is_del)
    @identify   = identify    # string
    @frequency  = frequency   # integer
    @add_time   = add_time    # integer
    @is_del     = is_del      # 0 or 1
  end

  class << self
    def new_info(identify)
      WordInfo.new identify, 1, Time.now.to_i, DEL_FALSE
    end

    def table_name
      'word_infos'
    end

    def add_frequency(identify, step=1)
      self.execute(
          "UPDATE #{self.table_name} SET frequency = frequency + #{step} WHERE identify = ?",
          identify)
    end
  end

  def save
    self.class.execute("INSERT INTO #{self.class.table_name} VALUES (?, ?, ?, ?)",
                       [@identify, @frequency, @add_time, @is_del])
  end
end

