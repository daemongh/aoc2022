import Base.parse

function parse_grid(f)
    grid = Array{Int}[]
    linecounter = 1
    for line in eachline(f)
        line = split(line, "")
        line = map(x -> parse(Int, x), line)
        push!(grid, Array{Int}[])
        for item in line
            push!(grid[linecounter], item)
        end
        linecounter += 1
    end

    return grid
end

function fill_grid(filler)
    vis_grid = Array{Int}[]
    for i in 1:grid_x
        push!(vis_grid, Array{Int}[])
        for j in 1:grid_y
            push!(vis_grid[i], filler)
        end
    end
    return vis_grid
end

function check_north(grid, row, col)
    current = grid[row][col]
    score = 0
    next_row = row - 1
    blocked = false
    while next_row >= 1 && !blocked
        score += 1
        if grid[next_row][col] >= current
            blocked = true
        end
        next_row -= 1
    end
    return score
end

function check_south(grid, row, col)
    current = grid[row][col]
    score = 0
    next_row = row + 1
    blocked = false
    while next_row <= grid_y && !blocked
        score += 1
        if grid[next_row][col] >= current
            blocked = true
        end
        next_row += 1
    end
    return score
end

function check_west(grid, row, col)
    current = grid[row][col]
    score = 0
    next_col = col - 1
    blocked = false
    while next_col >= 1 && !blocked
        score += 1
        if grid[row][next_col] >= current
            blocked = true
        end
        next_col -= 1
    end
    return score
end

function check_east(grid, row, col)
    current = grid[row][col]
    score = 0
    next_col = col + 1
    blocked = false
    while next_col <= grid_x && !blocked
        score += 1
        if grid[row][next_col] >= current
            blocked = true
        end
        next_col += 1
    end
    return score
end

function find_scenic_scores(grid)
    scenic_grid = fill_grid(0)
    for row in 1:length(grid)
        for col in 1:length(grid[row])
            north_score = check_north(grid, row, col)
            south_score = check_south(grid, row, col)
            west_score = check_west(grid, row, col)
            east_score = check_east(grid, row, col)

            score = north_score * south_score * west_score * east_score
            scenic_grid[row][col] = score
        end
    end

    return scenic_grid
end

function find_max_score(scenic_grid)
    max_score = 0
    for row in 1:length(scenic_grid)
        for col in 1:length(scenic_grid[row])
            if scenic_grid[row][col] > max_score
                max_score = scenic_grid[row][col]
            end
        end
    end
    return max_score
end

f = open("day8input2.txt")

grid = parse_grid(f)
grid_x = length(grid[1])
grid_y = length(grid)

scenic_grid = find_scenic_scores(grid)

println("Max score: $(find_max_score(scenic_grid))")


