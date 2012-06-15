module JslintRb
  ##
  #Not sure what to call this class, but it basically parses
  #the commandline args and puts them in instance vars. pass -h to
  #see a list of valid command line opts
  class OptionParser
    require 'optparse'

    attr_reader :options
    attr_reader :filename

    ##
    #These are just some defaults that I wanted.
    #Part of the fun in writing software is imposing your
    #opinions on people.
    DEFAULT_OPT =
    { white: false,
      undef: true,
      bitwise: true,
      onevar: true,
      curly: true,
      latedef: true,
      newcap: true,
      noarg: true,
      trailing: true,
      eqeqeq: true,
      eqnull: true
    }

    def initialize
      @filename = ARGV[0]

      @options = {
        #The JavaScript cmdline program to call
        js_cmd: 'rhino',
        #Location of the jslint.js file
        lint_location: File.expand_path("js/jshint.js", File.dirname(__FILE__)),
        #regex that will take output from Jslint and reformat it for use
        #with VIM
        pattern: /Lint at line (\d+) character (\d+): (.*)/,
        #tempfile location; make sure it's writable by your user
        temp_file: 'jslint_wrap.tmp',
        #this is passed to JSLint so that it will not falsely call
        #an undefined error on them
        global_vars: "Ext,console,Compass,currentUser",
        #A hash of JSHINT options
        lint_options: {}
        #default_options: ['white: false', 'nomen: false', 'undef: true']
      }

      ARGV.options do |opt|
        opt.banner = "Usage: jslint-rb [FILENAME] [OPTIONS]"

        opt.on('-o', "--options ['OPTIONNAME : VALUE',]", Array,
               "List of JsHint options. "\
               "Passing default : true will "\
               "enable default options") do |options|

          options.each do |lint_opt|
            key,value = lint_opt.split(':')
            if key == 'default'
              @options[:lint_options].merge!(DEFAULT_OPT)
            else
              @options[:lint_options][key] = value
            end
          end
        end

        opt.on_tail("-h", "--help", 'Show this message') do
          puts opt
          exit
        end
        opt.parse!
      end

    end

  end
end
