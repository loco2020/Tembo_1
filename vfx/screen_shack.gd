extends Node

var tween = self.create_tween()
var amplitude = 0
@onready var camara = get_parent()

func start(duration = 0.2, frequency = 15, amplitude = 15):
	
	self.amplitude = amplitude
	$duration.wait_time = duration
	$frequency.wait_time = 1/ float(frequency)
	$duration.start()
	$frequency.start()
	
func _new_shake():
	
	var rand = Vector2()
	rand.x = randf_range(-amplitude,amplitude)
	rand.y = randf_range(-amplitude,amplitude)
	print(camara.position)
	tween.tween_property(camara,"offset",rand,0.1)
	tween.start()

func _reset():
	tween.tween_property(camara,"offset",Vector2(),0.1)
	tween.start()
	
func _on_frequency_timeout():
	_new_shake()

func _on_duration_timeout():
	_reset()
	$frequency.stop()
