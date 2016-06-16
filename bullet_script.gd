
extends Sprite

# member variables here, example:
# var a=2
# var b="textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass




func _on_enemyBullet_enter( body ):
	if body.get_name() == "bullet":
		get_node("/root/Panel").remove_child(body)
		get_parent().queue_free()
