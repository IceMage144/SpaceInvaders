
extends Node2D

const Bullet = preload("res://bullet.xscn")
const Top_alien = preload("res://top_alien.xscn")
const Middle_alien = preload("res://middle_alien.xscn")
const Botton_alien = preload("res://botton_alien.xscn")

onready var ship = get_node("ship")
onready var ship_pos = ship.get_pos()
onready var clock1 = [0, 4]
onready var enemyshottime = [0, rand_range(0.5, 1.25)]

var ship_speed = 150
var screen_size = Vector2(622, 768)
var new_bullet = Bullet.instance()
var enemies = [[], [], [], [], []]
var ultenemy = [5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5]

func _ready():
	#cria os aliens
	#se mudar as poscoes dos aliens mudar no tempo do tiro tbm
	for i in range(11):
		enemies[0].append(Top_alien.instance())
		enemies[0][i].set_pos(Vector2(50 + 50*i, 100))
		add_child(enemies[0][i])
		for j in range(2):
			enemies[j+1].append(Middle_alien.instance())
			enemies[j+1][i].set_pos(Vector2(50 + 50*i, 100 + 50*(j+1)))
			add_child(enemies[j+1][i])
		for k in range(2):
			enemies[k+3].append(Botton_alien.instance())
			enemies[k+3][i].set_pos(Vector2(50 + 50*i, 100 + 50*(k+3)))
			add_child(enemies[k+3][i])
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
	if has_node("bullet") == true:
		if new_bullet.get_pos().y < 50:
			remove_child(new_bullet)
	#clock de 1s
	clock1[0] += delta
	if clock1[0] >= 0.5:
		for j in range(11):
			if enemies[clock1[1]][j] != null:
				enemies[clock1[1]][j].set_pos(Vector2(enemies[clock1[1]][j].get_pos().x + 20, enemies[clock1[1]][j].get_pos().y))
		#clock para as linhas
		if clock1[1] == 0:
			clock1[1] = 4
		else:
			clock1[1] -= 1
		clock1[0] = 0
	#tempo de tiro dos aliens
	enemyshottime[0] += delta
	for j in range(11):
		var selenemy = 0
		if enemies[ultenemy[j]][j].get_pos().x < ship_pos.x+50:
			if enemies[ultenemy[j]][j].get_pos().x > ship_pos.x-50:
				if enemyshottime[0] >= enemyshottime[1]:
					if enemies[ultenemy[(j+1)%11]][(j+1)%11] != null:
						if enemies[ultenemy[(j+1)%11]][(j+1)%11].get_pos().x < ship_pos.x+50:
							selenemy = 1
					elif enemies[ultenemy[(j-1)%11]][(j-1)%11] != null:
						if enemies[ultenemy[(j-1)%11]][(j-1)%11].get_pos().x < ship_pos.x-50:
							selenemy = -1
					enemyshottime[0] = 0
					enemyshottime[1] = rand_range(0.5, 1,25)
				 
	
	
	
func _input(event):
	#só atira se a bullet n estiver na tela
	if event.is_action_pressed("player_shoot") and has_node("bullet")==false:
		new_bullet.set_pos(Vector2(ship_pos.x, ship_pos.y-30))
		add_child(new_bullet)

#deleta o alien da matriz de inimigos
func anounce_death(object):
	for i in range(5):
		for j in range(11):
			if enemies[i][j] == object:
				var a=i+1
				enemies[i][j] = null
				#verifica qual o ultimo alien da coluna
				for k in range(i+1, 5):
					if enemies[k][j] != null:
						ultenemy[j] = k
				if a != 1:
					while ultenemy[j] == i+1 and a != 0:
						if enemies[a-1][j] != null:
							ultenemy[j] = a
						a -= 1
				else:
					ultenemy[j] = 0
