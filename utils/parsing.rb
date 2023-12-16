class Parser 
    def self.toIntArray(subject, delimeter=",")
        subject.strip().split(delimeter).map &:to_i
    end
end