# using DataStructures

function read_input(filename::String)
    drawings = nothing
    bingos = Matrix[]
    rr = r"([0-9]+)"
    current_field = Matrix{Int}(undef, 5,5)
    current_row = 1
    open(filename) do file
        for (i,line) in enumerate(eachline(file))
            if i == 1
                drawings = [parse(Int64,t.match) for t in eachmatch(rr, line)]
            elseif line == ""
                push!(bingos, current_field)
                current_row = 1
                current_field = Matrix{Int}(undef, 5,5)
            else
                numbers = [parse(Int64,t.match) for t in eachmatch(rr, line)]
                current_field[current_row, :] = numbers
                current_row += 1
            end
        end
    end
    return drawings, bingos
end

function solve1(drawings, bingos)
    rowcount = Dict{Int, Dict{Int, Int}}()
    colcount = Dict{Int, Dict{Int, Int}}()
    for (i, number) in enumerate(drawings)
        for (b, field) in enumerate(bingos)
 
            pos = findfirst(x -> x == number, field)
            if pos !== nothing
                bingo_counts = Int[]
                # mark number
                row = pos[1]
                col = pos[2]
                field[row, col] = -1
                # increment row and column count for that board
                field_count = get!(rowcount, b, Dict{Int, Int}())
                row_occ = get!(field_count, row, 0) + 1
                rowcount[b][row] = row_occ
                push!(bingo_counts, row_occ)

                field_count = get!(colcount, b, Dict{Int, Int}())
                col_occ = get!(field_count, col, 0) + 1
                colcount[b][col] = col_occ
                push!(bingo_counts, col_occ)
                if any(i -> i==5, bingo_counts) #board wins
                    unmarked_idx = findall(x -> x>=0, field)
                    answer = sum(field[unmarked_idx]) * number
                    return answer
                end
            end
        end
    end
end

function solve2(drawings, bingos)
    rowcount = Dict{Int, Dict{Int, Int}}()
    colcount = Dict{Int, Dict{Int, Int}}()
    answer = 0
    winners = Int[]
    for (i, number) in enumerate(drawings)
        for (b, field) in enumerate(bingos)
 
            pos = findfirst(x -> x == number, field)
            if pos !== nothing && !(b in winners)
                bingo_counts = Int[]
                # mark number
                row = pos[1]
                col = pos[2]
                field[row, col] = -1
                # increment row and column count for that board
                field_count = get!(rowcount, b, Dict{Int, Int}())
                row_occ = get!(field_count, row, 0) + 1
                rowcount[b][row] = row_occ
                push!(bingo_counts, row_occ)

                field_count = get!(colcount, b, Dict{Int, Int}())
                col_occ = get!(field_count, col, 0) + 1
                colcount[b][col] = col_occ
                push!(bingo_counts, col_occ)
                if any(i -> i==5, bingo_counts) #board wins
                    unmarked_idx = findall(x -> x>=0, field)
                    answer = sum(field[unmarked_idx]) * number
                    push!(winners, b)
                end
            end
        end
    end
    return answer
end

drawings, bingos = read_input("input.txt")
answer = solve1(drawings, deepcopy(bingos))
println("Answer is $answer")
answer = solve2(drawings, deepcopy(bingos))
println("Answer is $answer")