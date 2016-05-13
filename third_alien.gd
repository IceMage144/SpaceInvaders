
extends AnimatedSprite

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