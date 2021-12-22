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

    def is_vertical?
        return @x1 == @x2
    end
    
    def is_horizontal?
        return @y1 == @y2
    end

    def is_diagonal? 
        return (@x2 - @x1).abs == (@y2 - @y1).abs
    end

    def is_valid? 
        return is_horizontal? || is_vertical? || is_diagonal?
    end

    def to_s
        return "#{x1},#{y1} -> #{x2},#{y2}"
    end

    def min_x 
        return [@x1, @x2].min
    end
    
    def max_x
        return [@x1, @x2].max
    end

    def min_y 
        return [@y1, @y2].min
    end
    
    def max_y
        return [@y1, @y2].max
    end

    def get_points
        if(is_horizontal?)
            return (min_x..max_x).map { |x| [x, @y1]}
        elsif (is_vertical?)
            return (min_y..max_y).map { |y| [@x1, y]}
        else 
            x_vals = (min_x..max_x).to_a
            x_vals = x_vals.reverse if(@x1 != min_x)
            y_vals = (min_y..max_y).to_a
            y_vals = y_vals.reverse if(@y1 != min_y)
            return x_vals.map.with_index {|x, index| [x, y_vals[index]]}
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
        valid_vectors = @vectors.reduce([]) do |filtered_vectors, current_vector|
            filtered_vectors.push(current_vector) if(current_vector.is_valid?)
            filtered_vectors
        end
        puts "valid vector count: #{valid_vectors.size}"
        valid_vectors.each do |vector|
           points = vector.get_points
           points.each do |point|
                x, y = point
                @map[y][x] += 1
           end
        end
    end

    def print_map
        @map.each { |row| puts row.map{|col| col == 0 ? '.' : col}.join }
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
        puts "final map"
        print_map
        puts "danger count #{danger_count}"
    end
end

VentFinder.new(input).solve()
