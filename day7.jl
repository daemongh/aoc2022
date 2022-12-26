using Logging
import Base.parse

logger = ConsoleLogger(stderr, Logging.Warn)
global_logger(logger)


struct Treenode
    parent::Int
    children::Vector{Int}
    name::String
    size::Int
end


function parse_commands(f)
    tree = Dict{Int, Treenode}()
    tree[1] = Treenode(0, [], "/", 0)

    current_node = 1
    node_counter = 1

    for line in eachline(f)
        if startswith(line, "\$ ")
            if startswith(line, "\$ cd")
                info = split(line, " ")
                name = info[3]
                if name == ".."
                    current_node = tree[current_node].parent
                else
                    if name == "/"
                        current_node = 1
                        continue
                    end
                    child_id = find_child_id(tree, current_node, name)
                    if child_id != Nothing
                        current_node = child_id
                    else
                        @error "Could not find child $name"
                    end
                end
            elseif startswith(line, "\$ ls")
                continue
            end
        else
            info = split(line, " ")
            if startswith(line, "dir")
                name = info[2]
                node_counter += 1
                tree[node_counter] = Treenode(current_node, [], name, 0)
                push!(tree[current_node].children, node_counter) 
            else
                name = info[2]
                size = parse(Int64, info[1])
                node_counter += 1
                tree[node_counter] = Treenode(current_node, [], name, size)
                push!(tree[current_node].children, node_counter) 
            end
        end
    end

    return tree
end

function find_child_id(tree, parent, name)
    for child in tree[parent].children
        if tree[child].name == name && tree[child].parent == parent
            return child
        end
    end
    return 0
end

function calculate_dir_size(tree, node, dirs)
    size = 0
    for child in tree[node].children
        if tree[child].size == 0
            dir_size, ___ = calculate_dir_size(tree, child, dirs)
            dirs[node] = dir_size
            size += dir_size
        else
            size += tree[child].size
        end
    end
    return size, dirs
end

function find_candidate(dirs, used_space, total_needed_space, total_space)
    available_space = total_space - used_space
    needed_space = total_needed_space - available_space
    candidate = sort(collect(values(filter(x -> last(x) > needed_space, dirs))))
    return first(candidate)
end


f = open("day7input2.txt")

tree = parse_commands(f)

dirs = Dict{Int, Int}()
used_space, dirs = calculate_dir_size(tree, 1, dirs)

total_space = 70000000
total_needed_space = 30000000
smallest_candidate = find_candidate(dirs, used_space, total_needed_space, total_space)

println("Smallest candidate: $smallest_candidate")
