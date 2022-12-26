function detect_start(line, size)
    for x in 1:length(line)
        packet_start = x
        packet_end = x + (size - 1)
        letters = line[packet_start:packet_end]
        if is_start_packet(letters)
            return packet_end
        end
    end

    return 0
end

function is_start_packet(letters)
    for letter in letters
        if count(letter, letters) > 1
            return false
        end
    end
    return true
end

f = open("day6input2.txt")
stream = readline(f)
# start = detect_start(stream, 4) # part 1
start = detect_start(stream, 14) # part 2
println(start)