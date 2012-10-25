class I18nInspector::DictHashTraverser::Recursive

  def initialize(dict_hash, delimiter='.')
    @dict_hash = dict_hash
    @delimiter = delimiter
  end
  
  def full_keys
    keys_for_hash(@dict_hash)
  end
  
  protected
  
  def keys_for_hash(h, scope=[])
    [].tap do |result|
      h.keys.each do |key|
        if key_is_scope?(h, key)
          result.push(*keys_for_hash(h[key], scope + [key]))
        else
          result << (scope + [key]).join(@delimiter)
        end
      end
    end
  end
  
  def key_is_scope?(hash, key)
    hash[key].is_a?(Hash)
  end
end