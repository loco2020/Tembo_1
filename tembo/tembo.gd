extends CharacterBody2D

const SPEED = 600.0
var sped = 0
var current_health = 100.0
var current_animation = "stand"
var damage = 0.0
var health = 0.0
var died = false
var boom_animation =  preload("res://vfx/explostion.tscn")
var point = preload("res://UI/point/point.tscn")
func _ready():
	$tembo_animation.play("stand")
	SignalManger.boomed.connect(shake)
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(_delta):

	# when sending knifes whatever ...
	var direction = Input.get_axis("ui_left", "ui_right")
	if !died:
		if direction:
			current_animation = "run"
			$tembo_animation.play(current_animation)
			if direction > 0:
				$tembo.flip_h = false
				$partcile_right.process_material.gravity = Vector3(-20.0,-200.0,0.0)
				sped = SPEED
			else:
				$tembo.flip_h = true
				sped = SPEED * -1
				
			velocity.x = direction * SPEED
			
		else:
		
			current_animation = "stand"
			velocity.x = move_toward(velocity.x, 0, SPEED)
			$tembo_animation.play(current_animation)
			
		move_and_slide()
	
func set_damage(damage):
	current_health -= damage
	# point ui ----->
	$hit_sound.play()
	var p = point.instantiate()
	p.point = damage
	p.state = "-"
	add_child(p)
	# ---------------------------------------->
	$hit_flash.play("hit_flash")
	
	$HealthBar.set_value_no_signal(current_health)
	if damage == 30:
		var boom = boom_animation.instantiate()
		add_child(boom)
func shake():
	$Camera2D.walk_screen_shake()
func set_health(health):
	current_health += health
	
		# point ui ----->
	if health > 0:
		$hup.play()
		var p = point.instantiate()
		p.point = damage
		p.state = "+"
		add_child(p)
	# ---------------------------------------->
	$HealthBar.set_value_no_signal(current_health)


