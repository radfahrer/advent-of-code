def getInput
    input_file = ARGV[0];
    File.read(input_file).split(/\n/)
end