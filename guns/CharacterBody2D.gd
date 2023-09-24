extends Area2D

var speed = 500.0
var dx = 0
var dy = 0
var target_pos = 0
# cuclate the discten and shoot at it
func _ready():
	var r =  atan2(target_pos.y - position.y ,target_pos.x - position.x)
	dx = cos(r) * 2
	dy = sin(r) * 2
	
func _process(delta):
	
	position.x += dx * speed * delta
	position.y += dy * speed * delta
	rotate(.8)
	
func _on_body_entered(body):
	queue_free()
	body.hit = true
	body.play_partcile()


func _on_hidden():
	queue_free() # Replace with function body.
