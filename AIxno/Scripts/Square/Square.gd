extends Area

var type:=-1
onready var x_an:=$X/Animations
onready var o_an:=$O/Animations

signal clicked

func _ready():
	pass

func activate():
	type=int(Globals.turn)
	if type:
		x_an.play("Enter")
	else:
		o_an.play("Enter")
	$CollisionShape.queue_free()
	Globals.turn=!Globals.turn

func _on_Square_input_event(_camera, event, _position, _normal, _shape_idx):
	if event is InputEventMouseButton:
		emit_signal("clicked", self)
		# activate()
	pass # Replace with function body.
