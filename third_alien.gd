
extends AnimatedSprite

const Bullet = preload("res://bullet.xscn")

func _ready():
	pass

func _on_bullet_enter( body ):
	if body.get_name() == "bullet":
		get_node("/root/Panel/bullet").queue_free()
		get_node("/root/Panel").anounce_death(get_parent())
		get_parent().queue_free()