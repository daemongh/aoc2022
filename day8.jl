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

function fill_vis_grid(filler)
    vis_grid = Array{Int}[]
    for i in 1:grid_x
        push!(vis_grid, Array{Int}[])
        for j in 1:grid_y
            push!(vis_grid[i], filler)
        end
    end
    return vis_grid
end

function mark_visible_w2e(grid, vis_grid)
    for row in 1:length(grid)
#         println("Checking row $row")
        highest = 0
        row_len = length(grid[row])
        for col in 1:row_len
#             println("[$row, $col] is $(grid[row][col])")
            if col == 1
                vis_grid[row][col] = 1
                highest = grid[row][col]
#                 println("[$row, $col] is visible because it's edge")
            end

            if grid[row][col] > highest
                vis_grid[row][col] = 1
#                 println("[$row, $col] is visible because it's higher than $highest")
#                 println("Updating highest col to $(grid[row][col]) (from $highest)")
                highest = grid[row][col]
            end
        end
    end
    return vis_grid
end

function mark_visible_e2w(grid, vis_grid)
    for row in 1:length(grid)
#         println("Checking row $row")
        highest = 0
        row_len = length(grid[row])
        for rev_col in 1:row_len
            # reverse indexing
            # 1 => 5
            # 2 => 4
            # 3 => 3
            # 4 => 2
            # 5 => 1
            col = row_len - rev_col + 1
#             println("[$row, $col] is $(grid[row][col])")
            if col == row_len
                vis_grid[row][col] = 1
                highest = grid[row][col]
#                 println("[$row, $col] is visible because it's edge")
            end

            if grid[row][col] > highest
                vis_grid[row][col] = 1
#                 println("[$row, $col] is visible because it's higher than $highest")
#                 println("Updating highest col to $(grid[row][col]) (from $highest)")
                highest = grid[row][col]
            end
        end
    end
    return vis_grid
end

function get_column(grid, col)
    column = []
    for row in 1:grid_y
        push!(column, grid[row][col])
    end
    return column
end

function mark_visible_n2s(grid, vis_grid)
    for col in 1:grid_x
        column = get_column(grid, col)
        highest = 0
        for row in 1:grid_y
#             println("[$row, $col] is $(column[row])")

            if row == 1
                vis_grid[row][col] = 1
                highest = column[row]
#                 println("[$row, $col] is visible because it's edge")
            end

            if column[row] > highest
                vis_grid[row][col] = 1
#                 println("[$row, $col] is visible because it's higher than $highest")
#                 println("Updating highest col to $(column[row]) (from $highest)")
                highest = column[row]
            end
        end
    end
    return vis_grid
end

function mark_visible_s2n(grid, vis_grid)
    for col in 1:grid_x
        column = get_column(grid, col)
        highest = 0
        for rev_row in 1:grid_x
            # reverse indexing
            # 1 => 5
            # 2 => 4
            # 3 => 3
            # 4 => 2
            # 5 => 1
            row = grid_x - rev_row + 1
#             println("[$row, $col] is $(column[row])")

            if row == grid_x
                vis_grid[row][col] = 1
                highest = column[row]
#                 println("[$row, $col] is visible because it's edge")
            end

            if column[row] > highest
                vis_grid[row][col] = 1
#                 println("[$row, $col] is visible because it's higher than $highest")
#                 println("Updating highest col to $(column[row]) (from $highest)")
                highest = column[row]
            end
        end
    end
    return vis_grid
end

f = open("day8input2.txt")

grid = parse_grid(f)
grid_x = length(grid[1])
grid_y = length(grid)

vis_grid = fill_vis_grid(0)
println(vis_grid)
vis_grid = mark_visible_e2w(grid, vis_grid)
vis_grid = mark_visible_w2e(grid, vis_grid)
vis_grid = mark_visible_n2s(grid, vis_grid)
vis_grid = mark_visible_s2n(grid, vis_grid)
println(vis_grid)

function sum_vis_grid(vis_grid)
    sum = 0
    for row in 1:length(vis_grid)
        for col in 1:length(vis_grid[row])
            sum += vis_grid[row][col]
        end
    end
    return sum
end

println("Visible: $(sum_vis_grid(vis_grid))")



