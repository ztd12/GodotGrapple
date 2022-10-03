extends PlayerState

export(NodePath) var _animation
onready var animated_sprite: AnimatedSprite = get_node(_animation)

func enter(_msg := {}) -> void:
	animated_sprite.play("slide")
	
func physics_update(delta: float) -> void:
	
	
	if not player.on_floor():
		state_machine.transition_to("Fall")
		return 
			
	
	if not is_zero_approx(player.get_input_direction()):
		player.velocity.x = lerp(player.velocity.x, 
								player.get_input_direction() * player.slide_speed,
								player.acceleration * delta)
		
	player.velocity.y += player.gravity * delta
	player.velocity = player.move_and_slide(player.velocity, Vector2.UP)
	
	if Input.is_action_just_pressed("jump"):
		state_machine.transition_to("Jump")
	elif is_zero_approx(player.get_input_direction()):
		state_machine.transition_to("Idle")
	# TODO if animation finishes go to idle or run
	# TODO make speed get slower as times goes on?
