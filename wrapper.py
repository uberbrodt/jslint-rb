"""
wrapper for JSLint

reformats output (<filename>:<line>:<column>:<message>)
allows specifying JSLint options via the command line

Usage:
  $ wrapper.py <filename> [options]
options is a collection of individual "<key>:<value>" arguments
"""

import sys
import subprocess
import re


# settings -- TODO: read from configuration file
cmd = "rhino"
lint = "/usr/local/lib/jslint.js"
pattern = r"Lint at line (\d+) character (\d+): (.*)"
tempFile = "/tmp/jslint_wrap"
global_vars = "Ext,console,Compass,currentUser"


def main(args):
    original = filename = args[1] # original filename might differ from actually linted file
    options = args[2:]
    if options:
        filename = setOptions(filename, options)
    command = [cmd, lint, filename]
    output = subprocess.Popen(command, stdout=subprocess.PIPE).communicate()[0]
    print "\n".join(reformat(output, pattern, original))
    return True


def reformat(text, pattern, filename):
    results = []
    regex = re.compile(pattern)
    for line in text.split("\n"):
        matches = regex.search(line)
        if matches:
            line = int(matches.groups()[0])
            char = int(matches.groups()[1])
            msg = matches.groups()[2]
            results.append("%s:%d:%d:%s" % (filename, line, char, msg))
    return results


def setOptions(filename, options):
    f = open(filename, "r")
    contents = "/*jslint %s */ /*global %s */ %s" % (" ".join(options), global_vars, f.read())
    f.close()
    f = open(tempFile, "w")
    f.write(contents)
    f.close()
    return tempFile


if __name__ == "__main__":
    status = not main(sys.argv)
    sys.exit(status)
