
extends Sprite

func _ready():
	set_fixed_process(true)
	
func _fixed_process(delta):
	if (get_pos().x <= -40 or get_pos().x >= 720):
		get_parent().queue_free()
	
func _on_Bullet_enter( body ):
	if body.get_name() == "bullet":
		get_node("/root/Panel").remove_child(body)
		get_parent().queue_free()