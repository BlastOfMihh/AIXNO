extends Area

var type:=Globals.NOONE
onready var x_an:=$X/Animations
onready var o_an:=$O/Animations

signal clicked

func _ready():
	pass

func activate(player_type):
	if player_type==Globals.BLACK:
		x_an.play("Enter")
		Globals.turn=Globals.WHITE
	else:
		o_an.play("Enter")
		Globals.turn=Globals.BLACK
	type=player_type
	$CollisionShape.queue_free()

func _on_Square_input_event(_camera, event, _position, _normal, _shape_idx):
	if event is InputEventMouseButton:
		emit_signal("clicked", self)
		# activate()
