with open("day1input2.txt") as f:
    lines = f.readlines()

totals = {}
counter = 1
totals[counter] = 0

for line in lines:
    if line.strip() == "":
        counter += 1
        totals[counter] = 0
    else:
        totals[counter] += int(line)

stotals = sorted(totals.items(), key=lambda x:x[1], reverse=True)


print(stotals)
print(stotals[0][1] +stotals[1][1] +stotals[2][1])