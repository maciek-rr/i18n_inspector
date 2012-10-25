class I18nInspector::Config
  attr_writer :dict_hash_traverser, :scope_generator, :extractor_backend,
    :file_finder
  
  def dict_hash_traverser
    @dict_hash_traverser ||= I18nInspector::DictHashTraverser::Recursive
  end
  
  def scope_generator
    @scope_generator ||= I18nInspector::ScopeGenerator::Rails
  end
  
  def extractor_backend
    @extractor_backend ||= I18nInspector::ExtractorBackend::Regexp
  end
  
  def file_finder
    @file_finder ||= I18nInspector::FileFinder
  end
  
end