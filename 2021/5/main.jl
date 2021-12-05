struct Pos 
    x::Int
    y::Int
end

function read_input(filename::String)
    sources = Pos[]
    targets = Pos[]
    rr = r"([0-9]+)"
    open(filename) do file
        for line in eachline(file)
            numbers = [parse(Int64,t.match) + 1 for t in eachmatch(rr, line)]
            source = Pos(numbers[1], numbers[2])
            target = Pos(numbers[3], numbers[4])
            push!(sources, source)
            push!(targets, target)
        end
    end
    return sources, targets
end

function solve1(sources, targets)
    sxm = maximum(p -> p.x, sources)
    sym = maximum(p -> p.y, sources)
    txm = maximum(p -> p.x, targets)
    tym = maximum(p -> p.y, targets)
    map = fill(0, max(tym, sym), max(sxm, txm))
    for i in 1:length(sources)
        start = sources[i]
        target = targets[i]
        # vertical line
        if start.x == target.x
            # print("V: $i Plot $start to $target")
            for j in min(start.y,target.y):max(start.y,target.y)
                map[j, start.x] += 1
            end
        # horizontal line
        elseif start.y == target.y
            # print("H: $i Plot $start to $target")
            for j in min(start.x,target.x):max(start.x,target.x)
                map[start.y, j] += 1
            end
        # else
            # println("Ignore $i $start to $target")
        end
        # show(stdout, "text/plain", map)
        # println()        
        
    end
    # println(sources)
    # println(targets)
    answer = length(findall(x -> x >= 2, map))
    return answer
end

function read_input(filename::String)
    sources = Pos[]
    targets = Pos[]
    rr = r"([0-9]+)"
    open(filename) do file
        for line in eachline(file)
            numbers = [parse(Int64,t.match) + 1 for t in eachmatch(rr, line)]
            source = Pos(numbers[1], numbers[2])
            target = Pos(numbers[3], numbers[4])
            push!(sources, source)
            push!(targets, target)
        end
    end
    return sources, targets
end

function solve2(sources, targets)
    sxm = maximum(p -> p.x, sources)
    sym = maximum(p -> p.y, sources)
    txm = maximum(p -> p.x, targets)
    tym = maximum(p -> p.y, targets)
    map = fill(0, max(tym, sym), max(sxm, txm))
    for i in 1:length(sources)
        start = sources[i]
        target = targets[i]
        # vertical line
        if start.x == target.x
            # print("V: $i Plot $start to $target")
            for j in min(start.y,target.y):max(start.y,target.y)
                map[j, start.x] += 1
            end
        # horizontal line
        elseif start.y == target.y
            # print("H: $i Plot $start to $target")
            for j in min(start.x,target.x):max(start.x,target.x)
                map[start.y, j] += 1
            end
        else
            # print("D: $i Plot $start to $target")
            slope_y = start.y < target.y ? 1 : -1
            slope_x = start.x < target.x ? 1 : -1
            x = start.x
            y = start.y
            while true
                map[y, x] += 1
                if x == target.x && y == target.y
                    break
                end
                x += slope_x
                y += slope_y
                
            end         
        end
        # show(stdout, "text/plain", map)
        # println()        
        
    end
    # println(sources)
    # println(targets)
    answer = length(findall(x -> x >= 2, map))
    return answer
end

s,t = read_input("input.txt")
answer = solve1(s,t)
println("Answer is $answer")
answer = solve2(s,t)
println("Answer is $answer")