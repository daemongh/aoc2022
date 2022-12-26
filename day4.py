with open("day4input2.txt") as f:
    raw_lines = f.readlines()
lines = []
for line in raw_lines:
    lines.append(line.strip())

overlaps = []
for line in lines:
    elf1, elf2 = line.split(",")
    e1pos = elf1.split("-")
    e1start = int(e1pos[0])
    e1end = int(e1pos[1])
    e2pos = elf2.split("-")
    e2start = int(e2pos[0])
    e2end = int(e2pos[1])
    e1len = e1end - e1start
    e2len = e2end - e2start

    if e1len > e2len:
        if e2start >= e1start and e2end <= e1end:
            overlaps.append((elf1, elf2))
    else:
        if e1start >= e2start and e1end <= e2end:
            overlaps.append((elf1, elf2))        
    

print(overlaps, len(overlaps))