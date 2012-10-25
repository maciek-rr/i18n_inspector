class I18nInspector::ExtractorBackend::Regexp
  KEY = /([a-zA-Z0-9\-_\.]+)/
  T_INVOCATION = /(?:I18n::|I18n\.|\s|^)(?:t|translate)/
  PARENTHESES_START = /[\(\ ]/
  PARENTHESES_END = /[\)]?/
  QUOTES_START = /["']|%\{|%\(/
  QUOTES_END = /(?:["']|\}|\))/
  PARAMS = /(?:[,]([\:\w =>\.,"'\{\}\[\]]+))/
  
  KEY_WITH_PARAMS = 
    /#{T_INVOCATION}#{PARENTHESES_START}(?:\s*#{QUOTES_START}|:)#{KEY}#{QUOTES_END}?\s*#{PARAMS}?#{PARENTHESES_END}/
  # (?:I18n::|\s|^)(?:t|translate)[\(\ ](?:["']|%\{|%\(|:)([a-zA-Z0-9\-_\.]+)(?:["']|\}|\))?(?:[,]([\:\w =>\.,"'\{\}\[\]]+))?[\)]? 
  
  SCOPE_HASH = /(?::|^)scope(?:\s*(?:=>|:)\s*)(?:['"\[]\s*)([a-zA-Z\.\:\s,]+)/ # XXX break down and move to o/class
  
  def initialize; end
  
  def extract_from_string(str)
    str.scan(KEY_WITH_PARAMS).map do |match_array|
      stringify_key_with_scope(match_array)
    end
  end

  protected
  
  def stringify_key_with_scope(match_array)
    key, options_hash_string = match_array
    if options_hash_string
      scope = parse_hash_string(options_hash_string)
      [scope, key].compact.join('.')
    else
      key
    end
  end
  
  def parse_hash_string(hash_string)
    hash_string.gsub(/[\{\}]/, '').scan(SCOPE_HASH).map do |result|
      result[0].gsub(/[:\s]/,'').gsub(/,/, '.')
    end.first
  end

end