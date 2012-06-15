module JslintRb
  ##
  #Formatters are used to parse the output from Lint and
  #transform it for use with other programs (or simply to
  #customize the output)
  module Formatter
    #This basic regex will grab the line number, the column position,
    #and the error or warning message from JSLint in that order.
    LINT_REGEX = /Lint at line (\d+) character (\d+): (.*)/

  end
end

require File.expand_path('formatter/vim', File.dirname(__FILE__))
