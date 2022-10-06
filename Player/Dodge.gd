extends PlayerState


export(NodePath) var _animation
onready var animated_sprite: AnimatedSprite = get_node(_animation)



func enter(_msg := {}) -> void:
	animated_sprite.play("dodge")
	
func physics_update(delta: float) -> void:
	
	if not player.is_on_floor():
		state_machine.transition_to("Fall")
		return 
			
	
	if not is_zero_approx(player.get_input_direction()):
		player.velocity.x = lerp(player.velocity.x, 
								player.get_input_direction() * player.dodge_speed,
								player.acceleration * delta)
	
	player.velocity.y += player.gravity * delta
	player.velocity = player.move_and_slide(player.velocity, Vector2.UP)
	
	if Input.is_action_just_pressed("jump"):
		state_machine.transition_to("Jump")
	elif is_zero_approx(player.get_input_direction()):
		state_machine.transition_to("Idle")
	elif animated_sprite.get_frame() == 5:
		if Input.is_action_just_pressed("move_left") or Input.is_action_just_pressed("move_right"):
			state_machine.transition_to("Run")
		state_machine.transition_to("Idle")
		
		
	#TODO add iframes
	#TODO fix hitbox
	#dodge is slower than slide, but makes gives you iframes
