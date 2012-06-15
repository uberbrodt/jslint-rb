Borne out of a set of Python/Bash scripts I had lugged around for several years. Decided
to turn into an actual program instead of setting it up on yet another machine.

##Features:
* Converted to ruby for easy portability
* Using ExecJS, so no dependency on a particular JS runtime
* You can specify a list of globals at the commandline (config file in the future)
  instead of having to update your source code files with ugly /*global x,y,z */
  declarations
* will also be able to configure multiple formatters easily for use in different environments
  (VIM, RubyMine, Continuous Integration, etc)

##UPDATE June 15th 2012:

Got ExecJS integrated, and enabled the formatting so it will work with VIM.
Also converted to using JSHint instead of JSLint. General refactoring as well,
but should be good enough for a general beta release

##UPDATE June 6th 2012:

Created a ruby version of this script.  Can be used like this:

jslint foo.js [OPTIONS]

requires ruby 1.9.x

This version is missing the pretty formatting for use with VIM/Emacs, but that should be added
soon.

#TODO:

1.  Make a task to pull the latest version of JSHint
2.  Test with MacVim
3.  Allow the specification of formatters at the command line
4.  Allow the spec of Globals from the commandline
5.  Allow configuration via a YAML file in the users home directory, so that you
    don't have to input the same commandline options each time
