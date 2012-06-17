module JslintRb
  ##
  #This class uses ExecJS to execute the JSHINT function with the
  #config options provided.  Uses MultiJson to dump the Ruby objects to
  #well formatted JS.
  class Runner
    require 'execjs'
    require 'multi_json'

    def initialize(filename, options)
      @filename = filename
      @config = options
    end

    ##
    #Executes JSHint, with the options and globals provided.
    #Converts the JS output to an array of JslintRb::Error objects
    def execute
      context = ExecJS.compile(File.read(@config[:lint_location]))
      output = context.exec("JSHINT(#{MultiJson.dump(File.read(@filename))},"\
                            "#{MultiJson.dump(@config[:lint_options])},"\
                            "#{MultiJson.dump(@config[:global_vars])});"\
                            "return JSHINT.errors")
      output.compact.map {|x| JslintRb::Error.new(x) }
    end

  end#Runner
end#JslintRb
