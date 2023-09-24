extends Camera2D

@onready var shake_timer = $duration
@onready var shake_intensity = 0
var defulat_offset = offset
@export var walk_shake_intensity = 1

 

func _ready():

	set_process(false)
	randomize()
	
func _process(delta):
	var shake_vec = Vector2(randf_range(-1,1) * shake_intensity,randf_range(-1,1)*shake_intensity)
	var tween = create_tween()
	tween.tween_property(self, "offset", shake_vec, 0.1)

func shake(intensity):
	shake_intensity = intensity
	set_process(true)
	shake_timer.start()
func _on_duration_timeout():
	set_process(false)
	var tween = create_tween()
	tween.tween_property(self,"offset",defulat_offset,0.1)

func walk_screen_shake():

	shake(walk_shake_intensity)
