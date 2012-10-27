class I18nInspector::ScopeGenerator::Rails
  FOLDED_KEY_START = /\A\./
  KEY_SCOPE_DELIMITER = '.'
  VIEWS_DIR_NAME = 'views'
  
  def full_key(key, source_filename)
    if key_folded?(key) 
      scope = scope_for_file(source_filename)
      unfold_key(key, scope)
    else
      key
    end
  end
  
  protected
  
  def unfold_key(key, scope)
    (scope + [key.sub(FOLDED_KEY_START, '')]).compact.
      join(KEY_SCOPE_DELIMITER)
  end
  
  def key_folded?(key)
    key =~ FOLDED_KEY_START
  end
  
  def scope_for_file(fullname)
    dir = File.dirname(fullname)
    if view_dir?(dir)
      key = filename_to_key(fullname)
      view_dir_to_scope(dir) + [key]
    else
      []
    end
  end

  def filename_to_key(filename)
    File.basename(filename).
      split('.').first.
      sub(/\A_/, '') # partial 
  end
  
  def view_dir_to_scope(dir)
    dir.split(VIEWS_DIR_NAME).last.sub(/\A\//, '').split('/')    
  end
  
  def view_dir?(dir)
    dir.include?("/#{VIEWS_DIR_NAME}")
  end
  
end