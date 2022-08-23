extends RichTextLabel


func _process(delta):
	text="Jucatorul cu "
	if Globals.turn:
		text+=" X "
	else : text+=" 0 "
	text+="trebuie sa execute o mutare"
	
