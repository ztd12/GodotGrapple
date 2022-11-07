extends PlayerState


export(NodePath) var _animation
onready var animated_sprite: AnimatedSprite = get_node(_animation)

export(NodePath) var _hk
onready var grppl: Node2D = get_node(_hk)

func enter(_msg := {}) -> void:
	animated_sprite.play("crnr_grb")

func physics_update(_delta: float) -> void:
	
	if owner.taking_damage:
		state_machine.transition_to("Takehit")
	if owner.dead:
		state_machine.transition_to("Dead")
		
	if Input.is_action_just_pressed("crouch") and (not player.on_floor()):
		state_machine.transition_to("Fall")
		return 
		
	#if not player.on_ledge():
	#	state_machine.transition_to("Fall")
	
	
	player.velocity.x = 0
	if animated_sprite.flip_h == true:
		player.velocity.x = -500
	player.velocity.y = 0
	player.velocity = player.move_and_slide(player.velocity, Vector2.UP)
	
	if Input.is_action_just_pressed("jump"):
		state_machine.transition_to("Jump")
	#elif Input.is_action_just_pressed("attack"):
	#	state_machine.transition_to("Attack")
	#elif Input.is_action_just_pressed("dodge"):
	#	state_machine.transition_to("Dodge")
	#elif not is_zero_approx(player.get_input_direction()):
	#	state_machine.transition_to("Run")
	elif Input.is_action_just_pressed("grapple"):
		
		grppl.shoot(player.get_local_mouse_position())
		state_machine.transition_to("Hook")
