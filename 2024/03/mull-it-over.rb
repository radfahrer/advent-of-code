require '../../file_reader.rb'

lines = getInput();

puts "number of lines: #{lines.length}"

pattern = /mul\((\d{1,3}),(\d{1,3})\)/

scans = lines.map { |line| line.scan(pattern) }

#puts "scans: #{scans}"

matches = scans.flatten(1)

#puts "matches: #{matches}"

solution = matches.reduce(0) {|sum, (a, b)| sum + (a.to_i * b.to_i) }

puts "solution: #{solution}"