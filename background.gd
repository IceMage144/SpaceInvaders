
extends Node2D

# member variables here, example:
# var a=2
# var b="textvar"
onready var ship = get_node("ship")
var ship_speed = 150
var screen_size = Vector2(500, 768)
onready var ship_pos = ship.get_pos()
func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_process(true)
	pass

func _process(delta):
	# Mexer nesses ifs se quiser ajustar as posições maxima e minima da nave
	if (ship_pos.x > 40 and Input.is_action_pressed("move_left")):
		ship_pos.x -= ship_speed*delta
	if (ship_pos.x < screen_size.x and Input.is_action_pressed("move_right")):
		ship_pos.x += ship_speed*delta
	ship.set_pos(ship_pos)
	print(ship_pos)

	

