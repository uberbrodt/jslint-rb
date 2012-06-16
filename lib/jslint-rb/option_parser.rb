module JslintRb
  ##
  #Not sure what to call this class, but it basically parses
  #the commandline args and puts them in instance vars. pass -h to
  #see a list of valid command line opts
  class OptionParser
    require 'optparse'
    require 'yaml'

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

    DEFAULT_GLOBALS = {
      Ext: true,
      console: true,
      Compass: true,
      currentUser: true
    }


    def initialize
      @filename = ARGV[0]

      @options = {
        #Location of the jslint.js file
        lint_location: File.expand_path("js/jshint.js", File.dirname(__FILE__)),
        #tempfile location; make sure it's writable by your user
        temp_file: 'jslint_wrap.tmp',
        #this is passed to JSLint so that it will not falsely call
        #an undefined error on them
        global_vars: {},
        #A hash of JSHINT options
        lint_options: {},
        #Formatter proc to use
        formatter_proc: nil
      }

      parse_config_file
      parse_cmdline_args
    end

    def load_globals globals
      globals.each do |global|
        key,value = global.split(':')
        if key == 'default'
          @options[:global_vars].merge!(DEFAULT_GLOBALS)
        else
          @options[:global_vars][key] = value
        end
      end
    end

    def load_lint_configs options
      options.each do |lint_opt|
        key,value = lint_opt.split(':')
        if key == 'default'
          @options[:lint_options].merge!(DEFAULT_OPT)
        else
          @options[:lint_options][key] = value
        end
      end
    end

    def get_formatter_constant constant
      @options[:formatter_proc] = eval('JslintRb::Formatter::'<< constant)
    end

    def parse_config_file
      config_file = File.read(File.join(ENV['HOME'],'.jslint-rb')) rescue nil
      return if config_file.nil?
      config = YAML::load(config_file)
      return if config == false
      load_globals config['global_vars'] unless config['global_vars'].nil?
      load_lint_configs config['lint_options'] unless config['lint_options'].nil?
      get_formatter_constant config['formatter_proc'] unless config['formatter_proc'].nil?
    end

    def parse_cmdline_args

      ARGV.options do |opt|
        opt.banner = "Usage: jslint-rb [FILENAME] [OPTIONS]"

        opt.on('-o', "--options ['OPTIONNAME : VALUE',]", Array,
               "List of JsHint options. "\
               "Passing default : true will "\
               "enable default options") do |options|
          load_lint_configs options
        end

        opt.on('-g', "--globals  ['GLOBALVAR' : BOOL]", Array,
               "array of globals.  Set them to true to allow them to be overridden") do |options|
          load_globals options
        end

        opt.on('-f', "--format FORMAT", String,
               "The string constant for the Formatter proc:
                                      VIM -- format for VIM make errorformat"
              ) do |option|
          get_formatter_constant option
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
