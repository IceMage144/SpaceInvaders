
extends Node2D

const Bullet = preload("res://bullet.xscn")
const Top_alien = preload("res://top_alien.xscn")

onready var ship = get_node("ship")
onready var ship_pos = ship.get_pos()
onready var clock1 = 0
var ship_speed = 150
var screen_size = Vector2(622, 768)
var new_bullet = Bullet.instance()
var top_alien = []

func _ready():
	for i in range(10):
		for j in range(2):
			top_alien.append(Top_alien.instance())
			top_alien[i].set_pos(Vector2(50 + 50*i, 100 + 50*j))
			add_child(top_alien[i])
	set_process_input(true)
	set_fixed_process(true)

func _fixed_process(delta):
	# Mexer nesses ifs se quiser ajustar as posições maxima e minima da nave
	if (ship_pos.x > 40 and Input.is_action_pressed("move_left")):
		ship_pos.x -= ship_speed*delta
	if (ship_pos.x < screen_size.x and Input.is_action_pressed("move_right")):
		ship_pos.x += ship_speed*delta
	#limite posicional da bullet
	ship.set_pos(ship_pos)
	if new_bullet.get_pos().y < 50:
		remove_child(new_bullet)
	#clock de 1s
	clock1 += delta
	if clock1 >= 1:
		
		clock1 = 0
	
	
func _input(event):
	#só atira se a bullet n estiver na tela
	if event.is_action_pressed("player_shoot") and has_node("bullet")==false:
		print("shoot")
		new_bullet.set_pos(Vector2(ship_pos.x, ship_pos.y-30))
		add_child(new_bullet)
