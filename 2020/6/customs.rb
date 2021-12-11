#!/usr/bin/env ruby

records = STDIN.read.split(/^$/)

def partOne(records) 
	counts = records.map do |record|
		answers = record.split(/\n/).reduce([]) do |characters, line| 
			characters + line.chars
		end
		answers.compact.uniq.count
	end
	counts.reduce(0) { |sum, count| sum + count }
end
def intersectArrays(firstArray, *remainingArrays)
	if(remainingArrays.size > 0) 
		firstArray.filter do |item| 
			remainingArrays.any? do |array| 
				array.include? item 
			end
		end
	else 
		firstArray
	end
	
end
def partTwo(records) 
	counts = records.map do |record|
		answers = record.split(/\s*\n/).compact.map do |line| 
			line.chars
		end
		answers = answers.filter { |array| !array.empty?}

		intersectArrays(*answers).uniq.size
	end
	counts.reduce(0) { |sum, count| sum + count }
end

solution = partOne(records)

puts "part 1: #{solution}"

solution2 = partTwo(records)

puts "part 2: #{solution2}"