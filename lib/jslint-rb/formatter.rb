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
        results << "#{filename}:#{error.line_number}:"\
        "#{error.character}:#{error.reason} -- #{error.evidence.strip}"
      end
      results
    end

    def initialize(formatter)
      @command = formatter
    end


    def print(errors, filename)
      output = @command.call(errors, filename)
      puts output
    end

  end
end

