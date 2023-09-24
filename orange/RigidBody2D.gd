extends RigidBody2D

var point = preload("res://UI/point/point.tscn")
var boom_animation =  preload("res://vfx/explostion.tscn")
var opj = ["milk","knife","knife","knife","grande","grande","grande"]

var hit = false
# Called when the node enters the scene tree for the first time.
var type = ""
var damage = 0.0
var health = 0.0


func _ready():

	type = (opj[randi_range(0,len(opj) - 1)])
	$type.play("orange")
	
func _process(_delta):
	if hit and type == "grande":
		boom_free()
		hit = false
	if position.y > 800:
		queue_free()
	

func type_change():
	$type.play(type)
	$shoop.play()
	#$Juice.emitting = true
	$partclie.play("partcile")

func boom_free():
	var boom = boom_animation.instantiate()
	add_child(boom)
	$AudioStreamPlayer2D.play()
	$Timer.start()
	SignalManger.boomed.emit()
func _on_hidden():
	queue_free()

func get_damage(): # return the damage
	return damage
	
func get_health():
	return health
	
func play_partcile():
	$partclie.play("partcile")
	var p = point.instantiate()
	p.point = 10
	p.state = "+"
	add_child(p)
	# ---------------------------------------->
func _on_collid_with_player_body_entered(body):
	
	# update health and damage
	if type == "orange":
		damage = 10.0
	if type == "milk":
		health = 5.0
	if type == "knife":
		damage = 10.0

	if type == "grande":
		damage = 30.0
		SignalManger.boomed.emit()
		
	
	body.set_damage(get_damage())
	body.set_health(get_health())
	queue_free()


func _on_timer_timeout():
	queue_free()


func _on_partc_timer_timeout():
	pass
