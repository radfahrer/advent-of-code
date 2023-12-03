def getInput(options = {})
    input_file = ARGV[0] || options[:file_name]
    input = File.read(input_file)
    if(options[:raw]) 
        return input
    elsif(options[:seperator])
        return input.split(options[:seperator])
    end
    return input.split(/\n/)
end