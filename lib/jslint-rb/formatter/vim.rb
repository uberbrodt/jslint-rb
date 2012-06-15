module JslintRb
  module Formatter
    ##
    #Formatter for use with VIM's :make command.  Set your errorformat
    #for JS files to '%f:%l:%c:%m' and it will work flawlessly with
    #:cope
    class Vim

      def self.format(text, filename)
        results = []

        text.split("\n").each do |line|
          matches = LINT_REGEX.match(line)
          if matches
            line = matches[1]
            char = matches[2]
            msg = matches[3]
            results << "#{filename}:#{line}:#{char}:#{msg}"
          end
        end

        results
      end

    end
  end
end
