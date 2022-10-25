extends PlayerState

export(NodePath) var _animation
onready var animated_sprite: AnimatedSprite = get_node(_animation)

export(NodePath) var _hitbox
onready var hitbox: Area2D = get_node(_hitbox)

export(NodePath) var _hk
onready var grppl: Node2D = get_node(_hk)

func enter(_msg := {}) -> void:
	hitbox.monitorable = true
	animated_sprite.play("slide")
	
func physics_update(delta: float) -> void:
	if owner.taking_damage:
		hitbox.monitorable = false
		state_machine.transition_to("Takehit")
	
	if not player.is_on_floor():
		hitbox.monitorable = false
		state_machine.transition_to("Fall")
		return 
			
	
	if not is_zero_approx(player.get_input_direction()):
		#player.velocity.x = lerp(player.velocity.x, 
		#						player.get_input_direction() * player.slide_speed,
		#						player.acceleration * delta)
		player.velocity.x = lerp(player.slide_speed *player.get_input_direction(),
								0, player.friction * delta)
	player.velocity.y += player.gravity * delta
	player.velocity = player.move_and_slide(player.velocity, Vector2.UP)
	
	if Input.is_action_just_pressed("jump"):
		hitbox.monitorable = false
		state_machine.transition_to("Jump")
	elif is_zero_approx(player.get_input_direction()):
		hitbox.monitorable = false
		state_machine.transition_to("Idle")
	elif animated_sprite.get_frame() == 5:
		hitbox.monitorable = false
		if Input.is_action_just_pressed("move_left") or Input.is_action_just_pressed("move_right"):
			state_machine.transition_to("Run")
		state_machine.transition_to("Idle")
		# TODO make speed get slower as times goes on
		
		#If we want to make slide slower as time goes on then use this for player.velocity.x:
		#	player.velocity = lerp(player.velocity.x,
		#						  0, player.friciton * delta)
		
		# slide is faster than dodge, but makes you vulnerable
