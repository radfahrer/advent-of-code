# Advent Of Code

Solutions to advent of code problems written in Ruby

Participating in Advent of Code helps keep my skills sharp. This repo tracks my progress.

## Running

Typically input will be provided in the form of a text file. The `file_reader.rb` utility is for reading input from text files. For example:

If `program.rb` looks like

```rb
require '../../file_reader.rb'

lines = getInput()

# code to parse lines here
```

Then you can run the folowing to run the program on sample input:

```
ruby program.rb sample.txt
```

or the following to read the puzzle input:

```
ruby program.rb input.txt
```
