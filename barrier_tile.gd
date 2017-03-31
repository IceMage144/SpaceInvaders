
extends Area2D

export var type = 0

func _ready():
	get_node("BarrierSprite").set_frame(0)
	if type == 0:
		get_node("BarrierSprite").set_animation("Full")
	elif type == 1:
		get_node("BarrierSprite").set_animation("SemiFull")
	elif type == 2:
		get_node("BarrierSprite").set_animation("Cup")
	elif type == 3:
		get_node("BarrierSprite").set_animation("Stairs")
	pass

func _on_bullet_enter( body ):
	var other = body.get_name()
	if other == "bullet" or other == "enemyBullet":
		var frame = get_node("BarrierSprite").get_frame()
		if frame == 0:
			if other == "bullet":
				get_node("BarrierSprite").set_frame(2)
			else:
				get_node("BarrierSprite").set_frame(1)
		if frame == 2 or frame == 1:
			get_node("BarrierSprite").set_frame(3)
			queue_free()
		if other == "bullet":
			get_node("/root/Panel/bullet").queue_free()
		else:
			get_node("/root/Panel/enemyBullet").queue_free()
	if other == "middle_alien" or other == "top_alien" or other == "botton_alien":
		queue_free()
	pass

