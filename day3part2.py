with open("day3input2.txt") as f:
    raw_lines = f.readlines()
lines = []
for line in raw_lines:
    lines.append(line.strip())

def find_common(first, second):
    commons = []
    for letter in first:
        if letter in commons:
            next
        elif letter in second:
            commons.append(letter)
    
    return "".join(commons)

def calc_priority(letter):
    ascii_prio = ord(letter)

    if ascii_prio > 96:
        prio = ascii_prio - 96
    else:
        prio = ascii_prio - 38

    return prio

def chunk(alist, size=3):
    pos = 0
    list_len = len(alist)
    end = 0
    while end <= list_len:
        start = end
        end += size
        yield alist[start:end]

prios = []
for group in chunk(lines):
    if not group: break
    first = group[0]
    second = group[1]
    third = group[2]


    common1 = find_common(first, second)
    common2 = find_common(second, third)
    common = find_common(common1, common2)
    print(first, second, third, common, calc_priority(common))
    
    #  calc_priority(common))
    prios.append(calc_priority(common))

print(sum(prios))