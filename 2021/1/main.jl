function read_input(filename::String)
    measurements = String[]
    open(filename) do file
        for line in eachline(file)
            push!(measurements, line)
        end
    end
    #measurements = map(x->parse(Int,x),measurements)
    measurements = parse.(Int, measurements)
    return measurements
end

function solve1(measurements::Vector{Int})
    len = length(measurements)
    answer = 0
    for i in 1:len-1
        if measurements[i] < measurements[i+1]
            answer += 1
        end
    end
    return answer
end

function solve2(measurements::Vector{Int})
    windows = Int[]
    len = length(measurements)
    for i in 1:len-2
        push!(windows, sum(measurements[i:i+2]))
    end
    len = length(windows)
    answer = 0
    for i in 1:len-1
        if windows[i] < windows[i+1]
            answer += 1
        end
    end
    return answer
end

m = read_input("input.txt")
answer = solve1(m)
println("Answer is $answer")
answer = solve2(m)
println("Answer is $answer")