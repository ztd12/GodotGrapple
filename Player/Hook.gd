extends PlayerState

export(NodePath) var _animation
onready var animated_sprite: AnimatedSprite = get_node(_animation)

export(NodePath) var _hk
onready var grppl: Node2D = get_node(_hk)

func enter(_msg := {}) -> void:
	animated_sprite.play("crnr-jmp")

func physics_update(delta: float) -> void:
	# Hook physics
	if grppl.hooked:
		# `to_local($Chain.tip).normalized()` is the direction that the chain is pulling
		player.chain_velocity = player.to_local(grppl.tip).normalized() * player.CHAIN_PULL
		if player.chain_velocity.y > 0:
			# Pulling down isn't as strong
			player.chain_velocity.y *= 0.55
		else:
			# Pulling up is stronger
			player.chain_velocity.y *= 1.65
		if sign(player.chain_velocity.x) != player.get_input_direction():
			# if we are trying to walk in a different
			# direction than the chain is pulling
			# reduce its pull
			player.chain_velocity.x *= 0.7
	else:
		# Not hooked -> no chain velocity
		player.chain_velocity = Vector2.ZERO
	player.velocity += player.chain_velocity
	
	player.velocity.y += player.gravity * delta
	player.velocity = player.move_and_slide(player.velocity, Vector2.UP)
	
	if Input.is_action_just_released("grapple"):
		grppl.release()
		state_machine.transition_to("Idle")
	elif Input.is_action_just_pressed("attack"):
		state_machine.transition_to("Attack")
