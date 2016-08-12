
extends Sprite


func _ready():
	pass

func _on_enemyBullet_enter( body ):
	if body.get_name() == "bullet":
		get_node("/root/Panel/bullet").queue_free()
		get_parent().queue_free()

