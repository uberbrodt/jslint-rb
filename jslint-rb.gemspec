Gem::Specification.new do |s|
  s.name          = 'jsline-rb'
  s.version       = '0.0.0'
  s.date          = '2012-06-06'
  s.summary       = 'Ruby wrapper to run and format JSLint, using execJS'
  s.authors       = ['Chris Brodt']
  s.email         = 'chris@uberbrodt.net'
  s.files         = Dir["{bin,lib}/**/*"] + ["README", 'GPL-3-LICENSE']

  s.bindir        = 'bin'
  s.executables   = ['jslint-rb']
end
