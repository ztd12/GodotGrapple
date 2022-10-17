extends PlayerState


export(NodePath) var _animation
onready var animated_sprite: AnimatedSprite = get_node(_animation)

export(NodePath) var _hurtbox
onready var hurtbox: Area2D = get_node(_hurtbox)

func enter(_msg := {}) -> void:
	hurtbox.monitoring = false
	animated_sprite.play("dodge")
	
func physics_update(delta: float) -> void:
	
	if not player.is_on_floor():
		hurtbox.monitoring = true
		state_machine.transition_to("Fall")
		return 
			
	
	if not is_zero_approx(player.get_input_direction()):
		player.velocity.x = lerp(player.velocity.x, 
								player.get_input_direction() * player.dodge_speed,
								player.acceleration * delta)
	
	player.velocity.y += player.gravity * delta
	player.velocity = player.move_and_slide(player.velocity, Vector2.UP)
	
	if Input.is_action_just_pressed("jump"):
		hurtbox.monitoring = true
		state_machine.transition_to("Jump")
	elif is_zero_approx(player.get_input_direction()):
		hurtbox.monitoring = true
		state_machine.transition_to("Idle")
	elif animated_sprite.get_frame() == 5:
		if Input.is_action_just_pressed("move_left") or Input.is_action_just_pressed("move_right"):
			hurtbox.monitoring = true
			state_machine.transition_to("Run")
		hurtbox.monitoring = true
		state_machine.transition_to("Idle")
		
		
	#TODO add iframes
	#TODO fix hitbox
	#dodge is slower than slide, but makes gives you iframes
	#TODO add air dodge state, so that you can dodge while using grapple hook or in the air jumping/falling.
