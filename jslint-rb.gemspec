Gem::Specification.new do |s|
  s.name          = 'jslint-rb'
  s.description   = 'Ruby wrapper to run and format JSHint, using execJS. It supports commandline arguments or a YAML config file to specify global variables and JSHint configs. JavaScript runtime independent so you can start linting without the hassle, on Linux, Windows, or Mac'
  s.summary       = 'Ruby wrapper to run and format JSHint, using execJS.'
  s.homepage      = 'https://github.com/uberbrodt/jslint-rb'
  s.version       = '0.5'
  s.date          = '2012-06-15'
  s.authors       = ['Chris Brodt']
  s.email         = 'chris@uberbrodt.net'
  s.files         = Dir["{bin,lib}/**/*"] + ["README.md", 'GPL-3-LICENSE']

  s.bindir        = 'bin'
  s.executables   = ['jslint-rb']
  s.add_dependency 'execjs', '~> 1.3.2'
  s.add_dependency 'multi_json', '~> 1.3.6'
end
