class_name MiniMax

# enum {W, B, N, BOTH}
const W=Globals.WHITE
const B=Globals.BLACK
const N=Globals.NOONE
const BOTH=Globals.BOTH

var generated:=false
var root:MMNode=null
var current_node

func update_current(next_sboard)->void:
	print("prev cur ", current_node.board.sboard)
	for ch in current_node.kids:
		print(ch.board.sboard, ch.value)
		if ch.board.sboard==next_sboard:
			current_node=ch
	print("cur cur ", current_node.board.sboard)
	current_node=current_node.best_kid
	print("\n")

func _get_best_move(converted_sboard):
	update_current(converted_sboard) #it's black's turn now
	return current_node.board.sboard


func setup_tree()->void:
	if !generated :
		root=MMNode.new()
		dfs_setup(root)
		generated=true
	current_node=root


func dfs_setup(curr, lvl=0)->void: #
	# lvl+=1
	# if(lvl==4):
	# 	return

	# print("lvl ",lvl); print(curr.board.board)
	var winner=curr.board.eval()
	match winner:
		Globals.WHITE:
			curr.value=1
			print("winner white")
			return
		Globals.BLACK:
			print("winner black")
			curr.value=-1
			return
	var possible_kids_sboards=curr.board.next_possible_sboards()
	if possible_kids_sboards.size()==0:
		curr.value=0
	else:
		for i in range(0, possible_kids_sboards.size()):
			var nxt_sbrd=possible_kids_sboards[i]
			var new_kid:MMNode
			if 1:
				new_kid=MMNode.new()
				new_kid.board.sboard=nxt_sbrd #.duplicate(true)
				new_kid.board.flip()
				curr.kids.push_back(new_kid)
				dfs_setup(new_kid,lvl)
			if curr.best_kid==null or -new_kid.value > -curr.best_kid.value:
				curr.best_kid=new_kid
				curr.value=-curr.best_kid.value
