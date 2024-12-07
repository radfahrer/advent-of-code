require '../../file_reader.rb'

lines = getInput();

class Report
  def initialize(line)
    @levels = line.split(/\s+/).map &:to_i
    puts "levels: #{@levels}"
  end 

  def isSafe
    (self.isDesc() || self.isAsc()) && self.isGradual()
  end

  def isDesc
    @levels.each_with_index.reduce(true) {|isDesc, levelWithIndex| isDesc && self.isLevelDesc(*levelWithIndex) }
  end

  def isAsc
    @levels.each_with_index.reduce(true) {|isAsc, levelWithIndex| isAsc && self.isLevelAsc(*levelWithIndex) }
  end

  def isGradual
    @levels.each_with_index.reduce(true) {|isGradual, levelWithIndex| isGradual && self.isLevelGradual(*levelWithIndex)}
  end

  def isLevelDesc(level, index)
    index == 0 || level < @levels[index -1]
  end

  def isLevelAsc(level, index) 
    index == 0 || level > @levels[index -1]
  end

  def isLevelGradual(level, index)
    difference = level - @levels[index-1]
    index == 0 || difference.abs <= 3 
  end
end

reports = lines.map {|line| Report.new(line)}

safty = reports.map {|report| report.isSafe()}

count = safty.reduce(0) { |count, isSafe| isSafe ? count + 1 : count}
puts "report safty: #{count}"