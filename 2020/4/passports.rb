#!/usr/bin/ruby
input = $stdin.read

records = input.split(/^$/)

def validateRecord(record) 
	validation_rules = {
	 'byr': lambda { |year| (1920..2002).include? year.to_i },
		'iyr': lambda { |year| (2010..2020).include? year.to_i },
		'eyr': lambda { |year| (2020..2030).include? year.to_i },
		'hgt': lambda do |height| 
			string, number, units = height.match(/(\d+)(in|cm)/).to_a

			valid = false 
			if units == 'in'
				valid = (59..76).include? number.to_i  
			elsif units == 'cm'
				valid = (150..190).include? number.to_i 
			end
			number && units && valid
		end,
		'hcl': lambda  { |color| color =~ /\#([a-f]|[0-9]){6}/ },
		'pid': lambda { |id| id =~ /\d{9}/ }
	}

	recordHash = record.split(/\s+/m).reduce({}) do |hash, entry| 
		key, value  = entry.split(':') 
		hash.store(key, value)
		hash
	end
	
	validation_rules.all? do |key_name, rule| 
		value = recordHash[key_name.to_s]
		value && rule.call(value)
	end
end

valid_record_count = records.count { |record| validateRecord(record) }

puts "valid records: #{valid_record_count}"