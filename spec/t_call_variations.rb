module TCallVariations
  protected
  
  # Generates an array of strings that represent possible I18n.translate invocations
  def t_call_variations(key, options=nil)
    invocations = ['I18n.t', 'I18n::t', 't', 'I18n.translate', 'I18n::translate', 'translate']
    parentheses = [['(',')'], [' ','']]
    quotes = [['"', '"'], ['\'', '\''], ['%{', '}'], ['%(', ')']]
    quotes = [['', '']] if key.is_a?(Symbol)
    key = key.inspect if key.is_a?(Symbol)
    [].tap do |variations|
      invocations.each do |i|
        parentheses.each do |p|
          quotes.each do |q|
            variations.push(*invocation_for_params(i, p, q, key, options))
          end
        end
      end
    end
  end
  
  def invocation_for_params(invocation, parentheses, quotes, key, options)
    [].tap do |invocation_strings|
      call_start = [invocation, parentheses[0], quotes[0], key, quotes[1]].join
      if options && options.is_a?(Hash) 
        options_str = options.inspect
        invocation_strings << [call_start, ', ', options_str, parentheses[1]].join
        invocation_strings << [call_start, ', ', options_str.gsub(/[\{\}]/, ''), parentheses[1]].join
      else
        invocation_strings << [call_start, parentheses[1]].join
      end
    end
  end

end