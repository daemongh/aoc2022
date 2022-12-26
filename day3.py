with open("day3input2.txt") as f:
    lines = f.readlines()

def find_common(first, second):
    for letter in first:
        if letter in second:
            return letter

def calc_priority(letter):
    ascii_prio = ord(letter)

    if ascii_prio > 96:
        prio = ascii_prio - 96
    else:
        prio = ascii_prio - 38

    return prio

prios = []
for line in lines:
    line = line.strip()
    comp_size = int(len(line)/2)
    first = line[0:comp_size]
    second = line[comp_size:comp_size*2]
    common = find_common(first, second)
    print(first, second, common, calc_priority(common))
    prios.append(calc_priority(common))

print(sum(prios))