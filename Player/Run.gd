extends PlayerState


export(NodePath) var _animation
onready var animated_sprite: AnimatedSprite = get_node(_animation)

export(NodePath) var _hk
onready var grppl: Node2D = get_node(_hk)

func enter(_msg := {}) -> void:
	animated_sprite.play("run")
	player.jumps_made = 0
	
func physics_update(delta: float) -> void:
	if owner.taking_damage:
		state_machine.transition_to("Takehit")
	if not player.on_floor():
		state_machine.transition_to("Fall")
		return 
			
	
	if not is_zero_approx(player.get_input_direction()):
		player.velocity.x = lerp(player.velocity.x, 
								player.get_input_direction() * player.speed,
								player.acceleration * delta)
		
	player.velocity.y += player.gravity * delta
	player.velocity = player.move_and_slide(player.velocity, Vector2.UP)
	
	if Input.is_action_just_pressed("jump"):
		state_machine.transition_to("Jump")
	elif Input.is_action_just_pressed("attack"):
		state_machine.transition_to("Attack")
	elif Input.is_action_just_pressed("dodge"):
		state_machine.transition_to("Dodge")
	elif Input.is_action_just_pressed("crouch"):
		state_machine.transition_to("Slide")
	elif is_zero_approx(player.get_input_direction()):
		state_machine.transition_to("Idle")
	elif Input.is_action_just_pressed("grapple"):
		# We clicked the mouse -> shoot
		grppl.shoot(player.get_local_mouse_position())
		state_machine.transition_to("Hook")
