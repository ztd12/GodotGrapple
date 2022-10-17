extends PlayerState


export(NodePath) var _animation
onready var animated_sprite: AnimatedSprite = get_node(_animation)

export(NodePath) var _hk
onready var grppl: Node2D = get_node(_hk)


func enter(_msg := {}) -> void:
	animated_sprite.play("fall")
	
	
func physics_update(delta: float) -> void:
	if owner.taking_damage:
		state_machine.transition_to("Takehit")
	
	if not is_zero_approx(player.get_input_direction()):
		player.velocity.x = lerp(player.velocity.x, 
								player.get_input_direction() * player.speed, 
								player.acceleration * delta)
	else:
		player.velocity.x = lerp(player.velocity.x, 0, player.air_friction * delta)	
	
	player.velocity.y += player.gravity * delta
	player.velocity = player.move_and_slide(player.velocity, Vector2.UP)
	
	if (player.velocity.y) < 0 or (not is_zero_approx(player.get_input_direction())):
		animated_sprite.play("crnr_jmp")
	
	if (player.jumps_made < player.maximum_jumps) and Input.is_action_just_pressed("jump"):
		state_machine.transition_to("Jump")	
	
	if Input.is_action_just_pressed("attack"):
		state_machine.transition_to("Attack")	

	if Input.is_action_pressed("grapple"):
		# We clicked the mouse -> shoot
		grppl.shoot(player.get_local_mouse_position())
		state_machine.transition_to("Hook")

	if player.is_on_floor():
		if is_zero_approx(player.get_input_direction()):
			state_machine.transition_to("Idle")
		else:
			state_machine.transition_to("Run")
			
	if player.position.y > 750:
		state_machine.transition_to("Dead", {falling_death = true})
		
		


		
