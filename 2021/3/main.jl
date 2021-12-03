function read_input(filename::String)
    binary_nums = String[]
    open(filename) do file
        for line in eachline(file)
            push!(binary_nums, line)
        end
    end
    return binary_nums
end


function solve1(numbers)
    gamma = ""
    epsilon = ""
    for i in 1:length(numbers[1])
        zero_count = 0
        for binstring in numbers
            if binstring[i] == '0'
                zero_count += 1
            end
        end
        if zero_count > 0.5 * length(numbers)
            gamma *= "0"
            epsilon *= "1"
        else
            gamma *= "1"
            epsilon *= "0"
        end
    end
    epsilon = parse(UInt64, epsilon, base=2) 
    gamma = parse(UInt64, gamma, base=2)
    return epsilon * gamma
end

function split_by_bit_value(remainders, i)
    one_bit_crit = String[]
    zero_bit_crit = String[]
    for binstring in remainders
        if binstring[i] == '0'
            push!(zero_bit_crit, binstring)
        else
            push!(one_bit_crit, binstring)
        end
    end
    return zero_bit_crit, one_bit_crit
end
    

function solve2(numbers)
    
    remaining_oxy = (numbers)
    remaining_co2 = (numbers)
    for i in 1:length(numbers[1])
        if length(remaining_oxy) > 1
            zero_bit_crit, one_bit_crit = split_by_bit_value(remaining_oxy, i)

            if length(zero_bit_crit) > length(one_bit_crit)
                remaining_oxy = (zero_bit_crit)
            else
                remaining_oxy = (one_bit_crit)
            end
        end
        if length(remaining_co2) > 1
            zero_bit_crit, one_bit_crit = split_by_bit_value(remaining_co2, i)
            if length(zero_bit_crit) > length(one_bit_crit)
                remaining_co2 = (one_bit_crit)
            else
                remaining_co2 = (zero_bit_crit)
            end
        end

    end
    oxy = parse(UInt64, remaining_oxy[1], base=2) 
    co2 = parse(UInt64, remaining_co2[1], base=2)
    return oxy * co2
end


numbers = read_input("input.txt")
answer = solve1(numbers)
println("Answer is $answer")
answer = solve2(numbers)
println("Answer is $answer")