extends RichTextLabel

func _process(_delta):
	if Globals.turn==Globals.WHITE:
		text="X a castigat"
	# elif Globals.turn==Globals.BLACK:
	else:
		text="0 a castigat"
