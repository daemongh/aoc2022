with open("day2input2.txt") as f:
    lines = f.readlines()

round = []
for line in lines:
    opp, plr = line.strip().split(" ")
    
    if opp == "A":
        round_score = 0
        if plr == "X":
            shape_score = 3
            outcome = 0
            round_score = shape_score + outcome

        elif plr == "Y":
            shape_score = 1
            outcome = 3
            round_score = shape_score + outcome

        elif plr == "Z":
            shape_score = 2
            outcome = 6
            round_score = shape_score + outcome

        else:
            print("wtf")

        round.append(round_score)

    elif opp == "B":
        round_score = 0
        if plr == "X":
            shape_score = 1
            outcome = 0
            round_score = shape_score + outcome

        elif plr == "Y":
            shape_score = 2
            outcome = 3
            round_score = shape_score + outcome

        elif plr == "Z":
            shape_score = 3
            outcome = 6
            round_score = shape_score + outcome

        else:
            print("wtf")

        round.append(round_score)

    elif opp == "C":
        round_score = 0
        if plr == "X":
            shape_score = 2
            outcome = 0
            round_score = shape_score + outcome

        elif plr == "Y":
            shape_score = 3
            outcome = 3
            round_score = shape_score + outcome

        elif plr == "Z":
            shape_score = 1
            outcome = 6
            round_score = shape_score + outcome

        else:
            print("wtf")

        round.append(round_score)
    
print(round, sum(round))