module JslintRb
  module Formatter
    ##
    #Formatter for use with VIM's :make command.  Set your errorformat
    #for JS files to '%f:%l:%c:%m' and it will work flawlessly with
    #:cope
    class Vim

      def self.format(errors, filename)
        results = []

        errors.each do |error|
          results << "#{filename}:#{error.line_number}:"\
          "#{error.character}:#{error.reason} -- #{error.evidence.strip}"
        end

        results
      end

    end
  end
end
