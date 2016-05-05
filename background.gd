
extends Node2D

const Bullet = preload("res://bullet.xscn")

# member variables here, example:
# var a=2
# var b="textvar"
onready var ship = get_node("ship")
var ship_speed = 150
var screen_size = Vector2(622, 768)
onready var ship_pos = ship.get_pos()
var new_bullet = Bullet.instance()
func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_process_input(true)
	set_fixed_process(true)

func _fixed_process(delta):
	# Mexer nesses ifs se quiser ajustar as posições maxima e minima da nave
	if (ship_pos.x > 40 and Input.is_action_pressed("move_left")):
		ship_pos.x -= ship_speed*delta
	if (ship_pos.x < screen_size.x and Input.is_action_pressed("move_right")):
		ship_pos.x += ship_speed*delta
	ship.set_pos(ship_pos)
	if new_bullet.get_pos().y < 50:
		remove_child(new_bullet)
	
func _input(event):
	if event.is_action_pressed("player_shoot") and has_node("bullet")==false:
		print("shoot")
		new_bullet.set_pos(Vector2(ship_pos.x, ship_pos.y-30))
		add_child(new_bullet)
