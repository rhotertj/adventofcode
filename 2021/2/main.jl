mutable struct Pos
    x::Int
    y::Int
end

mutable struct Pos2
    horizontal::Int
    depth::Int
    aim::Int
end

function read_input(filename::String)
    directions = String[]
    step = String[]
    open(filename) do file
        for line in eachline(file)
            dir, s = split(line, " ")
            push!(directions, dir)
            push!(step, s)
        end
    end
    step = parse.(Int, step)
    return directions, step
end

function solve1(directions::Vector{String}, step::Vector{Int})
    depth = Pos(0,0)
    for (i, dir) in enumerate(directions)
        if dir == "up"
            depth.y -= step[i]
        elseif dir == "down"
            depth.y += step[i]
        elseif dir == "forward"
            depth.x += step[i]
        end
    end
    return depth.x * depth.y
end

function solve2(directions::Vector{String}, step::Vector{Int})
    pos2 = Pos2(0, 0, 0)
    for (i, dir) in enumerate(directions)
        if dir == "up"
            pos2.aim -= step[i]
        elseif dir == "down"
            pos2.aim += step[i]
        elseif dir == "forward"
            pos2.horizontal += step[i]
            pos2.depth += pos2.aim * step[i]
        end
    end
    return pos2.depth * pos2.horizontal 
end

d,s = read_input("input.txt")
answer = solve1(d,s)
println("Answer is $answer")
answer = solve2(d,s)
println("Answer is $answer")