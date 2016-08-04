
extends Node2D

const Bullet = preload("res://bullet.xscn")
const Enemy_bullet = preload("res://enemyBullet.xscn")
const Top_alien = preload("res://top_alien.xscn")
const Middle_alien = preload("res://middle_alien.xscn")
const Botton_alien = preload("res://botton_alien.xscn")
const Bonus_alien = preload("res://bonus_alien.xscn")

onready var ship = get_node("ship")
onready var ship_pos = ship.get_pos()
onready var clock1 = [0.0, 0]
onready var enemyshottime = [0.0, rand_range(0.5, 1.25)]
onready var bonus_alien_clk = [0.0, 5, randi()%2]

var rand_var = 0
var ship_speed = 150
var top_line = 4
var screen_size = Vector2(622, 768)
var enemy_dir = Vector2(20, 0)
var new_bullet = Bullet.instance()
var new_enemy_bullet = Enemy_bullet.instance()
var new_bonus_alien = Bonus_alien.instance()
var enemies = [[], [], [], [], []]
var ultenemy = [5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5]
var enemyline = [11, 11, 11, 11, 11]

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
	ship.set_pos(ship_pos)
	#limite posicional da bullet
	if has_node("bullet") == true:
		if new_bullet.get_pos().y < 50:
			remove_child(new_bullet)
	if has_node("enemyBullet") == true:
		if new_enemy_bullet.get_pos().y > 800:
			remove_child(new_enemy_bullet)
	#clock para mexer os aliens 
	clock1[0] += delta
	if clock1[0] >= 0.5:
		for j in range(11):
			if enemies[4-clock1[1]][j] != null:
				enemies[4-clock1[1]][j].set_pos(enemies[4-clock1[1]][j].get_pos() + enemy_dir)
			#abaixar os aliens
			if (ultenemy[j] != 0):
				if (enemies[ultenemy[j]-1][j].get_pos().x > 620):
					hit_edge("right")
				elif (enemies[ultenemy[j]-1][j].get_pos().x < 40):
					hit_edge("left")
		#clock para as linhas
		clock1[1] = (clock1[1]+1)%5
		while(enemyline[4-clock1[1]] == 0):
			clock1[1] = (clock1[1]+1)%5
		clock1[0] = 0
		
	#tempo de tiro dos aliens
	enemyshottime[0] += delta
	for j in range(11):
		var selenemy = 0
		if ultenemy[j] > 0:
			if enemies[ultenemy[j]-1][j].get_pos().x < ship_pos.x+50:
				#esses dois codigos(\/ e /\) selecionam um inimigo q esta peto da nave
				if enemies[ultenemy[j]-1][j].get_pos().x > ship_pos.x-50:
					if enemyshottime[0] >= enemyshottime[1]:
						#ve se o tempo de tiro 
						if ultenemy[(j+1)%11] != 0:
							if enemies[ultenemy[(j+1)%11]-1][(j+1)%11].get_pos().x < ship_pos.x+50:
								selenemy = 1 #seleciona o inimigo da direita
						elif ultenemy[(j-1)%11] != 0:
							if enemies[ultenemy[(j-1)%11]-1][(j-1)%11].get_pos().x > ship_pos.x-50:
								selenemy = -1 #seleciona o inimigo da esquerda
						else:
							selenemy = 0 #nao seleciona nem o da direita nem o da esquerda
						if has_node("enemyBullet") == false:
							if randf() <= 0.25:
								#primeiro inimigo atira
								new_enemy_bullet.set_pos(enemies[ultenemy[j]-1][j].get_pos())
							elif randf() <= 0.33:
								#segundo inimigo atira
								new_enemy_bullet.set_pos(enemies[ultenemy[(j+selenemy)%11]-1][(j+selenemy)%11].get_pos())
							else:
								#inimigo aleatorio atira
								rand_var = randi()%11
								new_enemy_bullet.set_pos(enemies[ultenemy[(j+rand_var)%11]-1][(j+rand_var)%11].get_pos())
							add_child(new_enemy_bullet)
						enemyshottime[0] = 0 #reseta o delta de tempo de tiro
						enemyshottime[1] = rand_range(1, 1.75) #seleciona outro delta para tiro
		else:
			if enemyshottime[0] >= enemyshottime[1]:
				rand_var = randi()%11
			if has_node("enemyBullet") == false:
				new_enemy_bullet.set_pos(enemies[ultenemy[(j+rand_var)%11]-1][(j+rand_var)%11].get_pos())
				add_child(new_enemy_bullet)
			enemyshottime[0] = 0 #reseta o delta de tempo de tiro
			enemyshottime[1] = rand_range(1, 1.75) #seleciona outro delta para tiro
	
	#clock para a aparição do alien bonus
	bonus_alien_clk[0] += delta
	if (bonus_alien_clk[0] >= bonus_alien_clk[1]):
		if (bonus_alien_clk[2] == 0):
			new_bonus_alien.set_pos(Vector2(-20, 20))
		else:
			new_bonus_alien.set_pos(Vector2(692, 20))
		add_child(new_bullet)
		bonus_alien_clk[0] = 0.0
		bonus_alien_clk[1] = rand_range(20, 40)
		bonus_alien_clk[2] = randi()%2

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
				#verifica quantos aliens tem em cada linha
				enemyline[i] -= 1
				if enemyline[4-top_line] == 0:
					top_line -= 1

func hit_edge(side):
	if (side == "right"):
		if (clock1[1] == top_line and enemy_dir == Vector2(20,0)):
			enemy_dir = Vector2(0, 20)
		elif (clock1[1] == top_line and enemy_dir == Vector2(0, 20)):
			enemy_dir = Vector2(-20, 0)
	elif (side == "left"):
		if (clock1[1] == top_line and enemy_dir == Vector2(-20,0)):
			enemy_dir = Vector2(0, 20)
		elif (clock1[1] == top_line and enemy_dir == Vector2(0, 20)):
			enemy_dir = Vector2(20, 0)