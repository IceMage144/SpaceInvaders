
extends RigidBody2D

func _ready():
	pass
	
func _on_enemyBullet_enter( body ):
	if body.get_name() == "enemyBullet":
		get_node("/root/Panel/enemyBullet").queue_free()
		get_parent().queue_free()
		get_node("/root/Panel").reborn()