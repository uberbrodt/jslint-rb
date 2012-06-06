module JslintRb
##
#The main ruby file that you call to run JSLint
#It is setup with some default options, that you will
#have to edit the class to override. Once I turn this
#into a gem, you'll be able to set these by config file
#or command line options.
  class Runner

    def initialize
      jslint_dir = 
      @config = {
        #The JavaScript cmdline program to call
        js_cmd: 'rhino',
        #Location of the jslint.js file
        lint_location: File.expand_path("js/jslint.js", File.dirname(__FILE__)),
        #regex that will take output from Jslint and reformat it for use
        #with VIM
        pattern: /Lint at line (\d+) character (\d+): (.*)/,
        #tempfile location; make sure it's writable by your user
        temp_file: 'jslint_wrap.tmp',
        #this is passed to JSLint so that it will not falsely call
        #an undefined error on them
        global_vars: "Ext,console,Compass,currentUser",
        #If no options passed, set  a few sane defaults.
        #set to empty array if you don't want these
        default_options: ['white: false', 'nomen: false']
      }

      @original = @filename = ARGV[0]
      @jslint_options = ARGV[1..(ARGV.count - 1)]
      @jslint_options = @config[:default_options] if @jslint_options.empty?
    end

    def execute
      set_jslint_options
      output = `#{@config[:js_cmd]} #{@config[:lint_location]} #{@config[:temp_file]}`
      puts output
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