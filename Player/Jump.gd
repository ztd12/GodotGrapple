extends PlayerState


export(NodePath) var _animation
onready var animated_sprite: AnimatedSprite = get_node(_animation)

func enter(_msg := {}) -> void:
	player.jumps_made += 1
	player.velocity.y = -player.jump_impulse
	animated_sprite.play("jump")
	
	
func physics_update(delta: float) -> void:
	
	if not is_zero_approx(player.get_input_direction()):
		player.velocity.x = lerp(player.velocity.x, 
								player.get_input_direction() * player.speed, 
								player.acceleration * delta)
	else:
		player.velocity.x = lerp(player.velocity.x, 0, player.air_friction * delta)
		
	
	player.velocity.y += player.gravity * delta
	player.velocity = player.move_and_slide(player.velocity, Vector2.UP)
	
	if (player.jumps_made < player.maximum_jumps) and Input.is_action_just_pressed("jump"):
		state_machine.transition_to("Jump")
		
	if player.velocity.y > 0:
		state_machine.transition_to("Fall")	
		
	if Input.is_action_just_pressed("attack"):
		state_machine.transition_to("Attack")	
	
	if player.is_on_floor(): #ALWAYS USE is_on_floor() RIGHT AFTER move_and_slide()
		if is_zero_approx(player.get_input_direction()):
			state_machine.transition_to("Idle")
		else:
			state_machine.transition_to("Run")
	

	
