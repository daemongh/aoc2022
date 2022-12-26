import Base.parse

function parse_grid(f)
    grid = Array{Int}[Array{Int}]()

    for line in eachline(f)
        line = split(line, "")
        line = map(x -> parse(Int, x), line)
        push!(grid, line)
    end

    return grid
end

f = open("day8input1.txt")

grid = parse_grid(f)
println(grid)