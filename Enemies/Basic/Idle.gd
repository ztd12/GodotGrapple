extends State

export(NodePath) var _animation
onready var animated_sprite: AnimatedSprite = get_node(_animation)

func enter(_msg := {}) -> void:
	animated_sprite.play("idle")
	
func physics_update(delta: float) -> void:
	
	if owner.detected_player == true:
		if owner.distance_to_player < 45:
			state_machine.transition_to("Attack")
		else:
			state_machine.transition_to("Run")
		
	if not owner.is_on_floor():
		state_machine.transition_to("Fall")
		return 
		
		
	owner.velocity.x = lerp(owner.velocity.x, 0, owner.friction * delta)
	owner.velocity = owner.move_and_slide(owner.velocity, Vector2.UP)
	
