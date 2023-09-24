extends Node2D

var orange = preload("res://orange/orange.tscn")
var game_start = false
var died = false
var time = 0.8
@export var boomed = false

func _ready():
	$Timer.wait_time = time
	$Node2D/CharacterBody2D/Camera2D.enabled = false

func _process(_delta):
	handle_ui_states()
	$end.position.x = $Node2D/CharacterBody2D.position.x - 100
	
func hide_except(node1):
	
	for child in get_children():
		if child.name != "Timer" and child.name != "Time" and child.name != node1:
			child.hide()
			
func show_except(node1,node2):
	for child in get_children():
		
		if child.name != "Timer" and child.name != "Time" and child.name != node1 and child.name != node2:
			child.show()
		
			
func handle_ui_states():
	
	if $main.get_state():
	
		game_start = true
		$main.hide()
		$Node2D/CharacterBody2D/Camera2D.enabled = true
	# chack when i died and return things to defuilt state
	
	if $Node2D/CharacterBody2D/HealthBar.value == 0:
		$Node2D/CharacterBody2D.died = true
		#$Node2D/CharacterBody2D.position.x = -5
		$end.show()
		$Node2D/CharacterBody2D.current_health = 100.0
		game_start = false
		hide_except('end')

	if $end.get_state():
		$Node2D/CharacterBody2D.died = false
		$end.hide()
		$end.set_state(false)
		time = 0.8
		$Timer.wait_time = time
		game_start = !$end.get_state()
		
		$Node2D/CharacterBody2D/HealthBar.set_value_no_signal(100.0)

		show_except('end','main')
		
		
func _on_timer_timeout():
	if game_start:
		
		var instance = orange.instantiate()
		# update the spawn position to the player pos
		var rang = RandomNumberGenerator.new()
		rang.randomize()
		var top = rang.randi_range($Node2D/CharacterBody2D.position.x - 400,$Node2D/CharacterBody2D.position.x + 800)
		
		instance.position.x = top
		add_child(instance)	


func _on_def_time_timeout():
	time = time / 1.2
	$Timer.wait_time = time
	
