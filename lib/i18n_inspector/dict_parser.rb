require "syck"

class I18nInspector::DictParser

  def initialize(dict_file, traverser_class)
    @dict_file = dict_file
    @traverse_class = traverser_class
  end
  
  def full_keys
    @full_keys ||= full_keys_from_traverser
  end
  
  protected
  
  def dictionary_hash
    @dictionary_hash ||= dictionary_hash_from_file
  end
  
  def dictionary_hash_from_file
    dictionary_hash_without_language_scope(Syck.load_file(@dict_file))
  end
  
  def dictionary_hash_without_language_scope(dh)
    dh.keys.size == 1 ? dh[dh.keys.first] : dh
  end
  
  def full_keys_from_traverser
    traverser.full_keys
  end
  
  def traverser
    @travreser_class.new(dictionary_hash)
  end
  
end