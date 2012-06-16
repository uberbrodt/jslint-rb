#Jslint-rb
Borne out of a set of Python/Bash scripts I had lugged around for several years. Decided
to turn into an actual program instead of setting it up on yet another machine.

###Features:
* Converted to ruby for easy portability
* Using ExecJS, so no dependency on a particular JS runtime
* You can specify a list of globals at the commandline (config file in the future)
  instead of having to update your source code files with ugly /*global x,y,z */
  declarations
* will also be able to configure multiple formatters easily for use in different environments
  (VIM, RubyMine, Continuous Integration, etc)

###Examples:

Install the gem and a js runtime
```bash
gem install jslint-rb
gem install therubyracer
```

Setup a config file in your $HOME directory, named .jslint-rb.  Then put the following in there

```yaml
global_vars:
 - default:true
formatter_proc: VIM
lint_options:
 - default:true
```
You should be all set to start linting your Javascript!  Output will be to STDOUT

```bash
jslint-rb foo.js
```

####TODO:

1.  Make a task to pull the latest version of JSHint
2.  Test with MacVim and Windows
