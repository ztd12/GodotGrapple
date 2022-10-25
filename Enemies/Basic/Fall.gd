extends State



export(NodePath) var _animation
onready var animated_sprite: AnimatedSprite = get_node(_animation)



func enter(_msg := {}) -> void:
	animated_sprite.play("fall")
	
	
func physics_update(delta: float) -> void:
	
	#if not is_zero_approx(owner.set_direction()):
	#	owner.velocity.x = lerp(owner.velocity.x, 
	#							owner.set_direction() * owner.speed, 
	#							owner.acceleration * delta)
	#else:
	owner.velocity.x = lerp(owner.velocity.x, 0, owner.air_friction * delta)	
	
	owner.velocity.y += owner.gravity * delta
	owner.velocity = owner.move_and_slide(owner.velocity, Vector2.UP)
	
	if owner.is_on_floor():
		state_machine.transition_to("Idle")
	
	if owner.position.y > 750:
		state_machine.transition_to("Death")
