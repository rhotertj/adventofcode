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

function solve1(population::Vector{Int})

    for i in 1:80
        birth_ready = findall(x -> x == 0 , population)
        population[birth_ready] .= 7
        for _ in 1:length(birth_ready)
            push!(population, 9)
        end
        population = map(x -> x-1, population)
    end
    return length(population)
end

function solve2(numbers::Vector{Int})
    population = zeros(9)
    for i in 1:9
        population[i] = count(x -> x == i, numbers)
    end
    for i in 1:256
        population[7] += population[9]
        population = circshift(population, 8)
    end
    return Int(sum(population))
end

numbers = read_input("input.txt")
answer = solve1(numbers)
println("Answer is $answer")
answer = solve2(numbers)
println("Answer is $answer")