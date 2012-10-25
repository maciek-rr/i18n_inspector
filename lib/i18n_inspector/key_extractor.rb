class I18nInspector::KeyExtractor
  
  def initialize(extractor_backend_class, scope_generator_class)
    @extractor_backend_class = extractor_backend_class
    @scope_generator_class = scope_generator_class
  end
  
  def from_string(search_string, source_filename)
    sg = scope_generator
    raw_keys(search_string).map do |key|
      sg ? sg.full_key(key, source_filename) : key
    end
  end
  
  def from_files(files)
    files.map { |f| from_string(File.read(f), scope_for_file(f)) }.flatten.uniq
  end
  
  protected
  
  def raw_keys(search_string)
    extractor_backend.extract_from_string(search_string).flatten
  end

  def extractor_backend
    @extractor_backend_class.new
  end
  
  def scope_generator
    @scope_generator_class && @scope_generator_class.new
  end

end