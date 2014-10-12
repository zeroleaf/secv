require_relative 'domain'

class Alias
  include Domain

  def initialize(a_from, a_to)
    @a_from = a_from  # string, unique
    @a_to   = a_to    # string
  end

  class << self
    def table_name
      'aliases'
    end

    def find_alias(a_from)
      a_to = nil
      Domain.execute(
          "SELECT a_to FROM #{self.table_name} WHERE a_from = ?", a_from) do |row|
        a_to = row[0]
      end
      a_to
    end
  end

  def save
    Domain.execute("INSERT INTO #{self.class.table_name} (a_from, a_to) VALUES (?, ?)",
                       [@a_from, @a_to])
  end

  def to_s
    "{a_from => '#{@a_from}', a_to => '#{@a_to}'}"
  end

end