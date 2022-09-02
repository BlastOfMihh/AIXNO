class_name Board

const W=Globals.WHITE
const B=Globals.BLACK
const N=Globals.NOONE

var sboard=[[N,N,N], [N,N,N], [N,N,N]]

func flip(): # swap white with black
	for i in range(0,3):
		for j in range(0,3):
			if sboard[i][j]==W:
				sboard[i][j]=B
			elif sboard[i][j]==B:
				sboard[i][j]=W

func next_possible_sboards():
	var ans=[]
	for i in range(0,3):
		for j in range(0,3):
			if sboard[i][j]==N:
				var new_sboard=sboard.duplicate(true)
				new_sboard[i][j]=W
				ans.push_back(new_sboard)
	return ans


func eval()->int:
	for i in range(0,3):
		if check_line(i):
			return sboard[i][0]
		if check_column(i):
			return sboard[0][i]
	if (sboard[0][0]!=N and sboard[0][0]==sboard[1][1] and sboard[1][1]==sboard[2][2]):
		return sboard[1][1]
	if (sboard[0][2]!=N and sboard[0][2]==sboard[1][1] and sboard[1][1]==sboard[2][0]):
		return sboard[1][1]
	return N

func check_line(line):
	var first_type=sboard[line][0]
	if first_type==N:
		return false
	for i in range(0,3):
		if sboard[line][i]!=first_type:
			return false
	return true

func check_column(column):
	var first_type=sboard[0][column]
	if first_type==N:
		return false
	for i in range(0,3):
		if sboard[i][column]!=first_type:
			return false
	return true
