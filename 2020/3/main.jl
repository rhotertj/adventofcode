function read_input(filename::String)
    landscape = String[]
    open(filename) do file
        for line in eachline(file)
            push!(landscape, line)
        end
    end
    return landscape
end

function solve1(landscape::Vector{String}, slope_x::Int, slope_y::Int)
    answer = 0
    x = 1
    biom_l = length(landscape[1])
    for y in range(1, length(landscape), step=slope_y)
        if landscape[y][x] == '#'
            answer += 1
        end
        # arrays are 1-indexed, get true value first and "correct" after modulo op
        x = ((x-1 + slope_x) % biom_l) + 1
        if y == 0
            break
        end
    end
    return answer
end

function solve2(landscape::Vector{String})
    answer = 1
    slopes = [(1,1), (3,1), (5,1), (7,1), (1,2)]
    for slope in slopes
        answer *= solve1(landscape, slope[1], slope[2])
    end
    return answer
end

landscape = read_input("input.txt")
answer = solve1(landscape, 3, 1)
println("Answer is: ", answer)
answer = solve2(landscape)
println("Answer is: ", answer)
