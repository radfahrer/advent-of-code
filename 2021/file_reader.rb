def getInput(options)
    input_file = ARGV[0]
    input = File.read(input_file)
    if(options[:raw]) 
        return input
    end
    return input.split(/\n/)
end