using Statistics

function read_input(filename::String)
    numbers = String[]
    open(filename) do file
        for line in eachline(file)
            numbers = split(line, ",")
        end
    end
    numbers = parse.(Int64, numbers)
    return numbers
end

function solve1(positions::Vector{Int})
    reference = median(positions)
    return sum(abs.(positions .-= reference))
end

function solve2(positions::Vector{Int})
    reference = round(mean(positions))
    w_size = round(length(positions) / 10)
    costs = Int[]
    for ref in reference-w_size:reference+w_size
        distances = abs.(copy(positions) .-= ref)
        push!(costs, sum(map(x -> sum(collect(1:x)), distances)))
    end
    return minimum(costs)
end

numbers = read_input("input.txt")
answer = solve1(copy(numbers))
println("Answer is $answer")
answer = solve2(copy(numbers))
println("Answer is $answer")