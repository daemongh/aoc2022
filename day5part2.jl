import Base.parse

function detect_columns(line)
    columns = convert(Int, (length(line) + 1) / 4)
    return columns
end

function column_pos(column)
    return column * 4 - 2
end

function parse(f)
    layout = []
    moves = []

    reading_moves = false

    for line in eachline(f)
        if line == ""
            reading_moves = true
            continue
        end

        if reading_moves
            push!(moves, line)
        else
            if startswith(line, " 1")
                continue
            end
            push!(layout, line)
        end
    end
    reverse!(layout)

    return layout, moves
end

function build_stacks(layout, columns)
    stacks = []

    for ___ in 1:columns
        push!(stacks, [])
    end
    
    for line in layout
        for column in 1:columns
            if line[column_pos(column)] == ' '
                continue
            else
                letter = line[column_pos(column)]
                push!(stacks[column], letter)
            end
        end
    end
    
    return stacks
end

function move_crates(stacks, moves)
    for move in moves
        move = split(move, " ")

        quantity = parse(Int64, String(move[2]))
        from = parse(Int64, String(move[4]))
        to = parse(Int64, String(move[6]))

        temp = []
        for ___ in 1:quantity
            push!(temp, pop!(stacks[from]))
        end
        for ___ in 1:quantity
            push!(stacks[to], pop!(temp))
        end

    end
    return stacks
end

function get_letters(stacks)
    letters = []
    for stack in stacks
        push!(letters, stack[end])
    end
    return join(letters)
end

f = open("day5input2.txt")
layout, moves = parse(f)
columns = detect_columns(first(layout))
stacks = build_stacks(layout, columns)
stacks = move_crates(stacks, moves)
letters = get_letters(stacks)
println(letters)
