extends RichTextLabel


func _process(_delta):
	text="Jucatorul cu "
	if Globals.turn==Globals.BLACK:
		text+=" X "
	else : text+=" 0 "
	text+="trebuie sa execute o mutare"
	
