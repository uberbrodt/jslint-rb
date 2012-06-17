module JslintRb
  ##
  #Formatters are used to parse the output from Lint and
  #transform it for use with other programs (or simply to
  #customize the output)
  class Formatter

    ##
    #Formatter for use with VIM's :make command.  Set your errorformat
    #for JS files to '%f:%l:%c:%m' and it will work flawlessly with
    #:cope
    VIM = Proc.new do |errors, filename|
      results = []
      errors.each do |error|
        fmt_err = "#{filename}:#{error.line_number}:"\
          "#{error.character}:#{error.reason}"
        results << fmt_err
      end
      results
    end

    ##
    #Multiline output suitible for a terminal window
    MULTI_LINE = Proc.new do |errors, filename|
      results = []

      #header
      results << "#########################################"
      results << "# Lint output for: #{filename}"
      results << "#########################################"

      errors.each do |error|
        results << "Error occured on line #{error.line_number} at col #{error.character}:"
        results << "    #{error.reason}"
        results << "EVIDENCE: #{error.evidence}" unless error.evidence.nil?
        results << "\n"
      end
      results
    end

    ##
    #Uses MULTI_LINE as a default
    def initialize(formatter)
      formatter = JslintRb::Formatter::MULTI_LINE if formatter.nil?
      @command = formatter
    end

    ##
    #Put the formatted JSHINT results to STDOUT
    def print(errors, filename)
      output = @command.call(errors, filename)
      puts output
    end

  end
end

