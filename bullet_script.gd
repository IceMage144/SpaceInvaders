
extends Sprite


func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _on_enemyBullet_enter( body ):
	if body.get_name() == "bullet":
		get_node("/root/Panel/bullet").queue_free()
		#get_node("/root/Panel").remove_child(get_parent()a)
		get_parent().queue_free()

