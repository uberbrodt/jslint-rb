module JslintRb
##
#The main ruby file that you call to run JSLint
#It is setup with some default options, that you will
#have to edit the class to override. Once I turn this
#into a gem, you'll be able to set these by config file
#or command line options.
  class Runner
    require 'execjs'
    require 'multi_json'

    def initialize(filename, options)
      @filename = filename
      @config = options
    end

    def execute
      #set_globals
      context = ExecJS.compile(File.read(@config[:lint_location]))
      output = context.exec("JSHINT(#{MultiJson.dump(File.read(@filename))},"\
                            "#{MultiJson.dump(@config[:lint_options])},"\
                            "#{MultiJson.dump(@config[:global_vars])});"\
                            "return JSHINT.errors")
      output.compact.map {|x| JslintRb::Error.new(x) }
    end

    ##
    #This prepends a list of globals to the file you're working on.
    #Saves it off to the location defined by @config[:temp_file]
    def set_globals
      f = File.open(@filename, 'r')
      contents = "/*global #{@config[:global_vars]} */ #{f.read}"
      f.close

      tmp_file_handle = File.open(@config[:temp_file], "w")
      tmp_file_handle.write(contents)
      tmp_file_handle.close()
    end

  end#Runner
end#JslintRb
