extends PlayerState


export(NodePath) var _animation
onready var animated_sprite: AnimatedSprite = get_node(_animation)

var chain_velocity:= Vector2.ZERO

func enter(_msg := {}) -> void:
	animated_sprite.play("crnr_jmp")
	
func physics_update(delta: float) -> void:
	
	if not player.on_floor():
		state_machine.transition_to("Idle")
		return 
		
		
	player.velocity.x = lerp(player.velocity.x, 0, player.friction * delta)
	player.velocity = player.move_and_slide(player.velocity, Vector2.UP)
	
	if Input.is_action_just_pressed("jump"):
		state_machine.transition_to("Jump")
	elif Input.is_action_just_pressed("attack"):
		state_machine.transition_to("Attack")
	elif Input.is_action_just_pressed("dodge"):
		state_machine.transition_to("Dodge")
	elif not is_zero_approx(player.get_input_direction()):
		state_machine.transition_to("Run")
