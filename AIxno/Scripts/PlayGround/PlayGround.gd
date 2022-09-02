extends Spatial

onready var winner_rect=$UI/WinnerRect
onready var draw_rect=$UI/DrawRect
onready var squares:=($Squares).get_children()
onready var board=[
	[squares[0], squares[1], squares[2]],
	[squares[3], squares[4], squares[5]],
	[squares[6], squares[7], squares[8]]
]
onready var minimax:MiniMax=MiniMax.new()

const N=Globals.NOONE
# 0 1 2
# 3 4 5
# 6 7 8
var winner:=Globals.NOONE
var occupied:=0

func _ready():
	for square in squares:
		square.connect("clicked", self, "_handle_player_moves")
	minimax.setup_tree();

func _handle_player_moves(square):
	if Globals.turn==Globals.WHITE:
		square.activate(Globals.WHITE)
	occupied+=1


func converted_sboard(): #write the func
	var converted=[[N, N, N], [N,N,N], [N,N,N]]
	for i in range(0,3):
		for j in range(0,3):
			if board[i][j].type==Globals.BLACK:
				converted[i][j]=Globals.WHITE
			elif board[i][j].type==Globals.WHITE:
				converted[i][j]=Globals.BLACK
	return converted


	
func get_robot_moves():
	#minimax Option
	if 1:
		var nxt_sboard=minimax._get_best_move(converted_sboard()) #write this
		for i in range(0,3):
			for j in range(0,3):
				if nxt_sboard[i][j]!=board[i][j].type:
					return board[i][j]
	# random option
	else:
		var square=board[randi()%3][randi()%3]
		while square.type!=Globals.NOONE:
			square=board[randi()%3][randi()%3]
		return square

func _process(_delta):
	if winner==Globals.NOONE: #check for the winner
		match check_winner():
			Globals.BLACK:
				print("x wins")
				winner=Globals.X
			Globals.WHITE:
				print("0 wins")
				winner=Globals.O
	if winner==Globals.NOONE: #handle moves if a winner still hasn't been chosen
		if occupied==9: #in case of a draw
			winner=Globals.BOTH
			draw_rect.visible=true
		elif Globals.turn==Globals.X: #the robot's turn
			var square=get_robot_moves();
			square.activate(Globals.BLACK)
			occupied+=1
	elif winner!=Globals.BOTH:
		winner_rect.visible=true
		Globals.turn=winner

func check_winner()->int:
	for i in range(0,3):
		if check_line(i) or check_column(i):
			return int(Globals.turn)
	if (board[0][0].type!=Globals.NOONE and board[0][0].type==board[1][1].type and board[1][1].type==board[2][2].type): return int(Globals.turn)
	if (board[0][2].type!=Globals.NOONE and board[0][2].type==board[1][1].type and board[1][1].type==board[2][0].type): return int(Globals.turn)
	return Globals.NOONE

func check_line(line):
	var first_type=board[line][0].type
	if first_type==Globals.NOONE:
		return false
	for i in range(0,3):
		if board[line][i].type!=first_type:
			return false
	return true

func check_column(column):
	var first_type=board[0][column].type
	if first_type==Globals.NOONE:
		return false
	for i in range(0,3):
		if board[i][column].type!=first_type:
			return false
	return true
