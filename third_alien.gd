
extends AnimatedSprite

const Bullet = preload("res://bullet.xscn")
var clockMonstro = 0
func _ready():
	set_process(true)
	
func _process(delta):
	clockMonstro += delta
	if clockMonstro >= 0.5:
		if get_frame() == 0:
			set_frame(1)
		else:
			set_frame(0)
		clockMonstro = 0

func _on_bullet_enter( body ):
	if body.get_name() == "bullet":
		get_node("/root/Panel").remove_child(body)
		get_node("/root/Panel").anounce_death(get_parent())
		get_parent().queue_free()
		
func anounce_hit():
	if (get_pos().x > 620):
		hit_edge("right")
	elif (get_pos().x < 60):
		hit_edge("left")