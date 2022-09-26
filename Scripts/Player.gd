extends KinematicBody2D

#2D Movement in Godot in Only 4 Minutes

#if we add crouch and slide, we can change from crouch hitbox by using $crouch_hitbox.disabled() = true

const UP_DIRECTION := Vector2.UP

export var speed := 200.0
export var jump_strength := 600.0
export var maximum_jumps := 2
export var double_jump_strength := 600.0
export var gravity := 2500.0

var _jumps_made := 0
var _velocity := Vector2.ZERO

func _physics_process(delta: float) -> void:
	var _horizontal_direction = (
		Input.get_action_strength("move_right")
		- Input.get_action_strength("move_left")
	)
	
	_velocity.x = _horizontal_direction * speed
	_velocity.y += gravity * delta
	
	var is_attacking := Input.is_action_just_pressed("attack") 
	var is_falling := _velocity.y > 0.0 and not is_on_floor()
	var is_jumping := Input.is_action_just_pressed("jump") and is_on_floor()
	var is_double_jumping := Input.is_action_just_pressed("jump") and is_falling
	var is_jump_cancelled := Input.is_action_just_released("jump") and _velocity.y < 0.0
	var is_idling := is_on_floor() and is_zero_approx(_velocity.x)
	var is_running := is_on_floor() and not is_zero_approx(_velocity.x)
	#TODO var is_hurt
	#TODO var is_dodging
	#TODO var is_crouching
	#TODO var is_dead
	#TODO var is_grappling
	#maybe TODO: var is_sliding, var is_slide_to_stand
	
	if is_jumping:
		_jumps_made += 1
		_velocity.y = -jump_strength
	elif is_double_jumping:
		_jumps_made += 1
		if _jumps_made <= maximum_jumps:
			_velocity.y = -double_jump_strength
	elif is_jump_cancelled:
		_velocity.y = 0.0
	elif is_idling or is_running:
		_jumps_made = 0
	
	
	_velocity = move_and_slide(
		_velocity, 
		UP_DIRECTION
		)
	
	#flip whatever animation is playing based on direciton
	if not is_zero_approx(_velocity.x):
		if sign(_velocity.x) < 0:
			$AnimatedSprite.flip_h = true
		else:
			$AnimatedSprite.flip_h = false
	
	
	#play correct animation
	if is_attacking:
		$AnimatedSprite.play("fight")
		
	if is_jumping or is_double_jumping:
		if $AnimatedSprite.animation == "fight" and $AnimatedSprite.is_playing():
			yield($AnimatedSprite, "animation_finished")
			$AnimatedSprite.play("jump")
		else:
			$AnimatedSprite.play("jump")
	elif is_running:
		if $AnimatedSprite.animation == "fight" and $AnimatedSprite.is_playing():
			yield($AnimatedSprite, "animation_finished")
			$AnimatedSprite.play("run")
		else:
			$AnimatedSprite.play("run")
	elif is_falling:
		if $AnimatedSprite.animation == "fight" and $AnimatedSprite.is_playing():
			yield($AnimatedSprite, "animation_finished")
			$AnimatedSprite.play("fall")
		else:
			$AnimatedSprite.play("fall")
	elif is_idling:
		if $AnimatedSprite.animation == "fight" and $AnimatedSprite.is_playing():
			yield($AnimatedSprite, "animation_finished")
			$AnimatedSprite.play("idle")
		else:
			$AnimatedSprite.play("idle")	
	
	
	
	"""
	if is_jumping or is_double_jumping:
		$AnimatedSprite.play("jump")
	elif is_running:
		$AnimatedSprite.play("run")
	elif is_attacking:
		$AnimatedSprite.play("fight")
	elif is_falling:
		$AnimatedSprite.play("fall")
	elif is_idling:
		if $AnimatedSprite.animation == "fight" and $AnimatedSprite.is_playing():
			yield($AnimatedSprite, "animation_finished")
			$AnimatedSprite.play("idle")
		else:
			$AnimatedSprite.play("idle")
	"""
	
