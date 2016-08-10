
extends AnimatedSprite

const Bullet = preload("res://bullet.xscn")
var clockMonstro = 0
func _ready():
	set_fixed_process(true)
	
func _fixed_process(delta):
	clockMonstro += delta
	if clockMonstro >= 0.5:
		if get_frame() == 0:
			set_frame(1)
		else:
			set_frame(0)
		clockMonstro = 0

func _on_bullet_enter( body ):
	if body.get_name() == "bullet":
		get_node("/root/Panel/bullet").queue_free()
		get_node("/root/Panel").anounce_death(get_parent())
		get_parent().queue_free()