extends RichTextLabel

func _process(_delta):
	if Globals.turn:
		text="X a castigat"
	else:
		text="0 a castigat"
