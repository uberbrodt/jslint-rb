module JslintRb
##
#The main ruby file that you call to run JSLint
#It is setup with some default options, that you will
#have to edit the class to override. Once I turn this
#into a gem, you'll be able to set these by config file
#or command line options.
  class Runner

    def initialize(filename, options)
      @filename = filename
      @config = options
      @jslint_options = []
      @jslint_options = @config[:default_options] if @jslint_options.empty?
    end

    def execute
      set_jslint_options
      output = `#{@config[:js_cmd]} #{@config[:lint_location]} #{@config[:temp_file]}`
      output
    end

    def set_jslint_options
      f = File.open(@filename, 'r')
      options = @jslint_options.join(" ") unless @jslint_options.nil?
      contents = "/*jslint #{options} */ /*global #{@config[:global_vars]} */ #{f.read}"
      f.close

      tmp_file_handle = File.open(@config[:temp_file], "w")
      tmp_file_handle.write(contents)
      tmp_file_handle.close()
    end

  end#Runner
end#JslintRb
