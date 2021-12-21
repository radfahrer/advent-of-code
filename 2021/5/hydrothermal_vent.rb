require '../file_reader.rb'

input = getInput()

class Vector
    attr_reader :x1, :x2, :y1, :y2

    def initialize(first_coord, second_coord)
        @x1, @y1 = parse_coord(first_coord)
        @x2, @y2 = parse_coord(second_coord)
    end

    def parse_coord(coord_string)
        return coord_string.split(",").map { |value| value.to_i }
    end

    def is_verticle?
        return @y1 == @y2
    end
    
    def is_horizontal?
        return @x1 == @x2
    end

    def is_valid? 
        return is_verticle? || is_horizontal?
    end

    def max_x
        return @x1 > @x2 ? @x1 : @x2
    end 

    def max_y
        return @y1 > @y2 ? @y1 : @y2
    end

    def to_s
        return "#{x1},#{y1} -> #{x2},#{y2}"
    end

    def low_x 
        return [@x1, @x2].min
    end
    
    def high_x
        return [@x1, @x2].max
    end

    def low_y 
        return [@y1, @y2].min
    end
    
    def high_y
        return [@y1, @y2].max
    end

    def get_points
        if(is_horizontal?) 
            return (low_y..high_y).map { |y| [@x1, y]}
        else 
            return (low_x..high_x).map { |x| [x, @y1]}
        end
    end
end

class VentFinder 
    def initialize(vectors)
        @vectors = vectors.map do |vector_string|
            first_coord, second_coord = vector_string.split(" -> ")
            Vector.new(first_coord, second_coord)
        end
        @map = Array.new(max_x + 1) { Array.new(max_y + 1, 0) }
    end

    def build_map
        valid_vectors = @vectors.reduce([]) do |filtered_vectors, vector| 
            filtered_vectors.push(vector) if(vector.is_valid?) 
            filtered_vectors
        end
        puts "valid vector count: #{valid_vectors.size}"
        valid_vectors.each do |vector|
           points = vector.get_points
           points.each do |point|
                x, y = point
                @map[x][y] += 1
           end
        end
    end

    def map_string
        @map.map { |row| row.join }.join("\n")
    end

    def danger_count
        @map.reduce(0) do |count, row|
            row.reduce(count) { |total, column| column >= 2 ? total += 1 : total }
        end
    end

    def max_x
        return @vectors.reduce(0) { |max, vector| max > vector.max_x ? max : vector.max_x } 
    end

    def max_y
        return @vectors.reduce(0) { |max, vector| max > vector.max_y ? max : vector.max_y } 
    end

    def solve
        build_map
        puts "danger count #{danger_count}"
    end
end

VentFinder.new(input).solve()
