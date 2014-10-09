require 'secv/domain/word'
require 'secv/domain/word_info'
require 'secv/domain/alias'

class DbLogic

  def save_word(word)
    word.save
    WordInfo.new_info(word.identify).save
  end

  def save_als_word(input, word)
    save_word word
    if input != word.identify
      Alias.new(input, word.identify).save
    end
  end

  def get_word(identify)
    word = Word.find_by_identify identify
    return nil unless word
    WordInfo.add_frequency identify
    word
  end

  def get_alias(a_from)
    Alias.find_alias a_from
  end

  def get_als_word(identify)
    word = get_word identify
    return word if word
    rel_identify = get_alias identify
    return nil unless rel_identify
    get_word rel_identify
  end
end