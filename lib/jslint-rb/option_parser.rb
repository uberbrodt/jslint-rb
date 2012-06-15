module JslintRb
  ##
  #Not sure what to call this class, but it basically parses
  #the commandline args and puts them in instance vars.  I still 
  #need to setup the OptParse part.
  class OptionParser
    attr_reader :options
    attr_reader :filename

    def initialize
      @filename = ARGV[0]
      @options = {
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
    end

  end
end
