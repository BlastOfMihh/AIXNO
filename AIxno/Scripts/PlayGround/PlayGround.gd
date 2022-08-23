extends Spatial

onready var winner_rect=$UI/WinnerRect
onready var draw_rect=$UI/DrawRect
onready var squares:=($Squares).get_children()
onready var board=[
	[squares[0], squares[1], squares[2]],
	[squares[3], squares[4], squares[5]],
	[squares[6], squares[7], squares[8]]
]
# 0 1 2
# 3 4 5
# 6 7 8
var winner:=-1
var occupied:=0

func _ready():
	for square in squares:
		square.connect("clicked", self, "_handle_moves")
#		print(square.name)

func _handle_moves(square):
	if !Globals.turn:
		square.activate()
	# print(square.name)
	occupied+=1


func _process(_delta):
	if winner==-1:
		# if Globals.turn
		match check_winner():
			0:
				print("x wins")
				winner=1
				pass
			1: #x wins
				print("0 wins")
				winner=0
	if winner==-1:
		if occupied==9:
			winner=2
			draw_rect.visible=true
		elif Globals.turn:
			var square=board[randi()%3][randi()%3]
			while square.type!=-1:
				square=board[randi()%3][randi()%3]
			square.activate()
			occupied+=1
	elif winner!=2:
		winner_rect.visible=true
		Globals.turn=winner

func check_line(line):
	var first_type=board[line][0].type
	if first_type==-1:
		return false
	for i in range(0,3):
		if board[line][i].type!=first_type:
			return false
	print(line)
	for i in range(0,3):
		print(board[line][i].name)
	return true

func check_column(column):
	var first_type=board[0][column].type
	if first_type==-1:
		return false
	for i in range(0,3):
		if board[i][column].type!=first_type:
			return false
	return true

func check_winner()->int:
	for i in range(0,3):
		if check_line(i) or check_column(i):
			return int(Globals.turn)
	if (board[0][0].type!=-1 and board[0][0].type==board[1][1].type and board[1][1].type==board[2][2].type): return int(Globals.turn)
	if (board[0][2].type!=-1 and board[0][2].type==board[1][1].type and board[1][1].type==board[2][0].type): return int(Globals.turn)
#
#	if (board[0][0].type!=-1 and board[0][0].type==board[1][0].type and board[1][0].type==board[1][0].type): return int(Globals.turn)
#	if (board[0][1].type!=-1 and board[0][1].type==board[1][1].type and board[1][1].type==board[1][1].type): return int(Globals.turn)
#	if (board[0][2].type!=-1 and board[0][2].type==board[1][2].type and board[1][2].type==board[1][2].type): return int(Globals.turn)
#
#	if (board[0][0].type!=-1 and board[0][0].type==board[0][1].type and board[0][1].type==board[0][2].type): return int(Globals.turn)
#	if (board[1][0].type!=-1 and board[1][0].type==board[1][1].type and board[1][1].type==board[1][2].type): return int(Globals.turn)
#	if (board[2][0].type!=-1 and board[2][0].type==board[2][1].type and board[2][1].type==board[2][2].type): return int(Globals.turn)
	return -1
