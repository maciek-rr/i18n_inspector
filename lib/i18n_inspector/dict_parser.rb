class I18nInspector::DictParser

  def initialize(dict_file_name, traverser_class, yml_parser_class)
    @dict_file_name = dict_file_name
    @traverser_class = traverser_class
    @yml_parser_class = yml_parser_class
  end
  
  def full_keys
    @full_keys ||= full_keys_from_traverser
  end
  
  protected
  
  def dictionary_hash
    dictionary_hash_without_language_scope(raw_dictionary_hash)
  end
  
  def raw_dictionary_hash
    @yml_parser_class.load_file(@dict_file_name)
  end
  
  def dictionary_hash_without_language_scope(dh)
    dh.keys.size == 1 ? dh[dh.keys.first] : dh
  end
  
  def full_keys_from_traverser
    traverser.full_keys
  end
  
  def traverser
    @traverser_class.new(dictionary_hash)
  end
  
end