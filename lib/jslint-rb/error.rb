module JslintRb
  ##
  #This object encapsulates the output from JSHint.  Does some
  #minimal formatting
  class Error
    ##
    #Line number the JSHint error occured on
    attr_reader :line_number
    ##
    #Column number of the JSHint error
    attr_reader :character
    ##
    #The actual error that was discovered
    attr_reader :reason
    ##
    #The snippet of code that caused the error
    attr_reader :evidence

    def initialize(jsobject)
      @line_number = jsobject["line"]
      @character = jsobject["character"]
      @reason = jsobject["reason"]
      @evidence = jsobject["evidence"]
      @evidence.strip! unless @evidence.nil?
    end

  end
end
